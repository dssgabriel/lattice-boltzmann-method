#include "lbm_comm.h"
#include "lbm_config.h"
#include "lbm_phys.h"
#include "lbm_struct.h"

#include <assert.h>
#include <immintrin.h>
#include <omp.h>
#include <stdlib.h>

#if DIRECTIONS == 9 && DIMENSIONS == 2
/// Definition of the 9 base vectors used to discretize the directions on each
/// mesh.
static double const direction_a[DIRECTIONS] = {
     0.0,  1.0,  0.0, 
    -1.0,  0.0,  1.0,
    -1.0, -1.0,  1.0
};
static double const direction_b[DIRECTIONS] = {
    0.0,  0.0,  1.0, 
    0.0, -1.0,  1.0,
    1.0, -1.0, -1.0
};
#else
    #error Need to defined adapted direction matrix.
#endif

#if DIRECTIONS == 9
/// Weigths used to compensate the differences in length of the 9 directional
/// vectors.
double const equil_weight[DIRECTIONS] = {
    4.0 / 9.0,  1.0 / 9.0,  1.0 / 9.0,  1.0 / 9.0,  1.0 / 9.0,
    1.0 / 36.0, 1.0 / 36.0, 1.0 / 36.0, 1.0 / 36.0,
};
#endif

inline double get_vect_norm_2(Vector const a, Vector const b)
{
    return a[0] * b[0] + a[1] * b[1];
}

#ifdef __AVX512F__
inline double get_cell_density(lbm_mesh_cell_t const cell)
{
    __m512d vcell = _mm512_loadu_pd(cell);
    double res = _mm512_reduce_add_pd(vcell);
    res += cell[DIRECTIONS - 1];
    return res;
}

inline void get_cell_velocity(Vector v, lbm_mesh_cell_t const cell,
                              double const cell_density)
{
    // Sum all directions and normalize
    __m512d dir_a = _mm512_loadu_pd(direction_a + 1);
    __m512d dir_b = _mm512_loadu_pd(direction_b + 1);
    __m512d vcell = _mm512_loadu_pd(cell + 1);
    v[0] = _mm512_reduce_add_pd(_mm512_mul_pd(vcell, dir_a)) / cell_density;
    v[1] = _mm512_reduce_add_pd(_mm512_mul_pd(vcell, dir_b)) / cell_density;
}
#else
inline double get_cell_density(lbm_mesh_cell_t const cell)
{
    double res = 0.0;
    for (size_t k = 0; k < DIRECTIONS; k++) {
        res += cell[k];
    }
    return res;
}

inline void get_cell_velocity(Vector v, lbm_mesh_cell_t const cell,
                              double cell_density)
{
    v[0] = 0.0;
    v[1] = 0.0;

    // Sum all directions
    for (size_t k = 1; k < DIRECTIONS; k++) {
        v[0] += cell[k] * direction_a[k];
        v[1] += cell[k] * direction_b[k];
    }

    // Normalize
    v[0] /= cell_density;
    v[1] /= cell_density;
}
#endif

inline double compute_equilibrium_profile(Vector velocity, double density,
                                          int direction)
{
    double const v2 = velocity[0] * velocity[0] + velocity[1] * velocity[1];
    // Compute `e_i * v_i / c`
    double const p1 = direction_a[direction] * velocity[0] +
                      direction_b[direction] * velocity[1];
    double const p2 = p1 * p1;
    // Terms without density and direction weight
    double f_eq = 1.0 + (3.0 * p1) + (4.5 * p2) - (1.5 * v2);
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
    double const tmp[DIRECTIONS] = {
        cell[0], cell[3], cell[4], cell[1], cell[2],
        cell[7], cell[8], cell[5], cell[6],
    };

    cell[0] = tmp[0];
    cell[1] = tmp[1];
    cell[2] = tmp[2];
    cell[3] = tmp[3];
    cell[4] = tmp[4];
    cell[5] = tmp[5];
    cell[6] = tmp[6];
    cell[7] = tmp[7];
    cell[8] = tmp[8];
}

inline double helper_compute_poiseuille(size_t const i, size_t const size)
{
    double const y = (double)(i - 1);
    double const L = (double)(size - 1);
    double const a = y * (L - y);
    double const b = L * L;
    return 0.4 * a / b;
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
    cell[1] = cell[3];
    cell[5] = cell[7] - 0.5 * (cell[2] - cell[4]) + (1.0 / 6.0) * (rho * v);
    cell[8] = cell[6] + 0.5 * (cell[2] - cell[4]) + (1.0 / 6.0) * (rho * v);
}

void compute_outflow_zou_he_const_density(lbm_mesh_cell_t cell)
{
#if DIRECTIONS != 9
    #error Implemented only for 9 directions
#endif

    // Now can compute unknown microscopic values
    cell[3] = cell[1];
    cell[6] = cell[8] + 0.5 * (cell[4] - cell[2]);
    cell[7] = cell[5] + 0.5 * (cell[2] - cell[4]);
}

void special_cells(Mesh* mesh, lbm_mesh_type_t* mesh_type,
                   lbm_comm_t const* mesh_comm)
{
    // Loop on all inner cells
    #pragma omp parallel
    {
        #pragma omp for schedule(static)
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
}

void collision(Mesh* mesh_out, const Mesh* mesh_in)
{
    // Loop on all inner cells
    #pragma omp parallel 
    {
        #pragma omp for schedule(static)
        for (size_t i = 1; i < mesh_in->width - 1; i++) {
            for (size_t j = 1; j < mesh_in->height - 1; j++) {
                compute_cell_collision(Mesh_get_cell(mesh_out, i, j), Mesh_get_cell(mesh_in, i, j));
            }
        }
    }
}

void propagation(Mesh* mesh_out, Mesh const* mesh_in)
{
    // Loop on all cells
    #pragma omp parallel 
    {
        #pragma omp for schedule(static)
        for (size_t i = 0; i < mesh_out->width; i++) {
            for (size_t k = 0; k < DIRECTIONS; k++) {
                double dir_a = direction_a[k];
                double dir_b = direction_b[k];
                for (size_t j = 0; j < mesh_out->height; j++) {
                    // Compute destination point
                    ssize_t ii = (i + dir_a);
                    ssize_t jj = (j + dir_b);
                    // Propagate to neighboor nodes
                    if ((ii >= 0 && ii < mesh_out->width) && (jj >= 0 && jj < mesh_out->height)) {
                        Mesh_get_cell(mesh_out, ii, jj)[k] = Mesh_get_cell(mesh_in, i, j)[k];
                    }
                }
            }
        }
    }
}
