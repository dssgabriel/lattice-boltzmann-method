#include "lbm_comm.h"
#include "lbm_config.h"
#include "lbm_phys.h"
#include "lbm_struct.h"

#include <assert.h>
#include <omp.h>
#include <stdlib.h>

#if DIRECTIONS == 9 && DIMENSIONS == 2
/// Definition of the 9 base vectors used to discretize the directions on each
/// mesh.
Vector const direction_matrix[DIRECTIONS] = {
    { +0.0, +0.0 }, { +1.0, +0.0 }, { +0.0, +1.0 },
    { -1.0, +0.0 }, { +0.0, -1.0 }, { +1.0, +1.0 },
    { -1.0, +1.0 }, { -1.0, -1.0 }, { +1.0, -1.0 },
};
#else
    #error Need to defined adapted direction matrix.
#endif

#if DIRECTIONS == 9
/// Weigths used to compensate the differences in lenght of the 9 directional
/// vectors.
double const equil_weight[DIRECTIONS] = {
    4.0 / 9.0,  1.0 / 9.0,  1.0 / 9.0,
    1.0 / 9.0,  1.0 / 9.0,  1.0 / 36.0,
    1.0 / 36.0, 1.0 / 36.0, 1.0 / 36.0,
};

/// Opposite directions for bounce back implementation
int const opposite_of[DIRECTIONS] = {
    0, 3, 4,
    1, 2, 7,
    8, 5, 6,
};
#else
    #error Need to defined adapted equilibrium distribution function
#endif

double get_vect_norm_2(Vector const a, Vector const b)
{
    double res = 0.0;
    for (size_t k = 0; k < DIMENSIONS; k++) {
        res += a[k] * b[k];
    }

    return res;
}

double get_cell_density(lbm_mesh_cell_t const cell)
{
    assert(cell != NULL);

    double res = 0.0;
    for (size_t k = 0; k < DIRECTIONS; k++) {
        res += cell[k];
    }

    return res;
}

void get_cell_velocity(Vector v, lbm_mesh_cell_t const cell,
                       double cell_density)
{
    assert(v != NULL);
    assert(cell != NULL);

    // Loop on all dimensions
    for (size_t d = 0; d < DIMENSIONS; d++) {
        v[d] = 0.0;

        // Sum all directions
        for (size_t k = 0; k < DIRECTIONS; k++) {
            v[d] += cell[k] * direction_matrix[k][d];
        }

        // Normalize
        v[d] /= cell_density;
    }
}

double compute_equilibrium_profile(Vector velocity, double density,
                                   int direction)
{
    double const v2 = get_vect_norm_2(velocity, velocity);

    // Compute `e_i * v_i / c`
    double const p1 = get_vect_norm_2(direction_matrix[direction], velocity);
    double const p2 = p1 * p1;

    // Terms without density and direction weight
    double f_eq = 1.0 + (3.0 * p1) + ((9.0 / 2.0) * p2) - ((3.0 / 2.0) * v2);

    // Multiply everything by the density and direction weight
    f_eq *= equil_weight[direction] * density;

    return f_eq;
}

void compute_cell_collision(lbm_mesh_cell_t cell_out,
                            lbm_mesh_cell_t const cell_in)
{
    // Compute macroscopic values
    double const density = get_cell_density(cell_in);
    Vector v;
    get_cell_velocity(v, cell_in, density);

    // Loop on microscopic directions
    for (size_t k = 0; k < DIRECTIONS; k++) {
        // Compute f at equilibrium
        double f_eq = compute_equilibrium_profile(v, density, k);
        // Compute f_out
        cell_out[k] = cell_in[k] - RELAX_PARAMETER * (cell_in[k] - f_eq);
    }
}

void compute_bounce_back(lbm_mesh_cell_t cell)
{
    double tmp[DIRECTIONS];
    for (size_t k = 0; k < DIRECTIONS; k++) {
        tmp[k] = cell[opposite_of[k]];
    }

    for (size_t k = 0; k < DIRECTIONS; k++) {
        cell[k] = tmp[k];
    }
}

double helper_compute_poiseuille(size_t const i, size_t const size)
{
    double const y = (double)(i - 1);
    double const L = (double)(size - 1);
    return 4.0 * INFLOW_MAX_VELOCITY / (L * L) * (L * y - y * y);
}

void compute_inflow_zou_he_poiseuille_distr(Mesh const* mesh,
                                            lbm_mesh_cell_t cell, size_t id_y)
{
#if DIRECTIONS != 9
    #error Implemented only for 9 directions
#endif

    // Set macroscopic fluid info
    // Poiseuille distribution on X and null on Y
    // We just want the norm, so `v = v_x`
    double const v = helper_compute_poiseuille(id_y, mesh->height);

    // Compute rho from U and inner flow on surface
    double const rho =
        (cell[0] + cell[2] + cell[4] + 2 * (cell[3] + cell[6] + cell[7])) /
        (1.0 - v);

    // Now compute unknown microscopic values
    cell[1] = cell[3]; // + (2.0/3.0) * density * v_y <- no velocity on Y so v_y = 0
    cell[5] = cell[7] - (1.0 / 2.0) * (cell[2] - cell[4]) +
              (1.0 / 6.0) * (rho * v); //+ (1.0/2.0) * density * v_y <- no velocity on Y so v_y = 0
    cell[8] = cell[6] + (1.0 / 2.0) * (cell[2] - cell[4]) +
              (1.0 / 6.0) * (rho * v); //- (1.0/2.0) * density * v_y    <--- no velocity on Y so v_y = 0

    // No need to copy already known one as the value will be "loss" in the wall
    // at propagatation time
}

void compute_outflow_zou_he_const_density(lbm_mesh_cell_t cell)
{
#if DIRECTIONS != 9
    #error Implemented only for 9 directions
#endif

    double const rho = 1.0;
    // Compute macroscopic velocity depending on inner flow going onto the wall
    double const v = -1.0 + (1.0 / rho) * (cell[0] + cell[2] + cell[4] +
                                           2 * (cell[1] + cell[5] + cell[8]));

    // Now can compute unknown microscopic values
    cell[3] = cell[1] - (2.0 / 3.0) * rho * v;
    cell[7] = cell[5] + (1.0 / 2.0) * (cell[2] - cell[4]) - (1.0 / 6.0) *
              (rho * v); // - (1.0 / 2.0) * (rho * v_y) <- no velocity on Y so v_y = 0
        
    cell[6] = cell[8] + (1.0 / 2.0) * (cell[4] - cell[2]) - (1.0 / 6.0) *
              (rho * v); // + (1.0 / 2.0) * (rho * v_y) <- no velocity on Y so v_y = 0
}

void special_cells(Mesh* mesh, lbm_mesh_type_t* mesh_type,
                   lbm_comm_t const* mesh_comm)
{
    // Loop on all inner cells
    for (size_t i = 1; i < mesh->width - 1; i++) {
        for (size_t j = 1; j < mesh->height - 1; j++) {
            switch (*(lbm_cell_type_t_get_cell(mesh_type, i, j))) {
                case CELL_FUILD:
                    break;
                case CELL_BOUNCE_BACK:
                    compute_bounce_back(Mesh_get_cell(mesh, i, j));
                    break;
                case CELL_LEFT_IN:
                    compute_inflow_zou_he_poiseuille_distr(
                        mesh, Mesh_get_cell(mesh, i, j), j + mesh_comm->y);
                    break;
                case CELL_RIGHT_OUT:
                    compute_outflow_zou_he_const_density(
                        Mesh_get_cell(mesh, i, j));
                    break;
            }
        }
    }
}

void collision(Mesh* mesh_out, const Mesh* mesh_in)
{
    assert(mesh_in->width == mesh_out->width);
    assert(mesh_in->height == mesh_out->height);

    // Loop on all inner cells
    for (size_t j = 1; j < mesh_in->height - 1; j++) {
        for (size_t i = 1; i < mesh_in->width - 1; i++) {
            compute_cell_collision(Mesh_get_cell(mesh_out, i, j),
                                   Mesh_get_cell(mesh_in, i, j));
        }
    }
}

void propagation(Mesh* mesh_out, Mesh const* mesh_in)
{
    // Loop on all cells
    for (size_t j = 0; j < mesh_out->height; j++) {
        for (size_t i = 0; i < mesh_out->width; i++) {
            // For all direction
            for (size_t k = 0; k < DIRECTIONS; k++) {
                // Compute destination point
                ssize_t ii = (i + direction_matrix[k][0]);
                ssize_t jj = (j + direction_matrix[k][1]);
                // Propagate to neighboor nodes
                if ((ii >= 0 && ii < mesh_out->width) &&
                    (jj >= 0 && jj < mesh_out->height))
                {
                    Mesh_get_cell(mesh_out, ii, jj)[k] =
                        Mesh_get_cell(mesh_in, i, j)[k];
                }
            }
        }
    }
}
