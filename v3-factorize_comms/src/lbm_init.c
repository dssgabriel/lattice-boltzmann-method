#include "../include/lbm_init.h"
#include "../include/lbm_phys.h"

#include <assert.h>
#include <mpi.h>

void init_cond_velocity_0_density_1(Mesh* mesh)
{
    assert(mesh != NULL);

    // Loop on all cells
    for (size_t i = 0; i < mesh->width; i++) {
        for (size_t j = 0; j < mesh->height; j++) {
            for (size_t k = 0; k < DIRECTIONS; k++) {
                Mesh_get_cell(mesh, i, j)[k] = equil_weight[k];
            }
        }
    }
}

void setup_init_state_circle_obstacle(Mesh* mesh, lbm_mesh_type_t* mesh_type,
                                      lbm_comm_t const* mesh_comm)
{
    // Loop on nodes
    for (size_t i = mesh_comm->x; i < mesh->width + mesh_comm->x; i++) {
        for (size_t j = mesh_comm->y; j < mesh->height + mesh_comm->y; j++) {
            if (((i - OBSTACLE_X) * (i - OBSTACLE_X)) + ((j - OBSTACLE_Y) * (j - OBSTACLE_Y)) <=
                OBSTACLE_R * OBSTACLE_R)
            {
                *(lbm_cell_type_t_get_cell(mesh_type, i - mesh_comm->x, j - mesh_comm->y)) = CELL_BOUNCE_BACK;
                // for (size_t k = 0; k < DIMENSIONS; k++) {
                //     mesh[i][j][k] = 0.0;
                // }
            }
        }
    }
}

void setup_init_state_global_poiseuille_profile(Mesh* mesh,
                                                lbm_mesh_type_t* mesh_type,
                                                lbm_comm_t const* mesh_comm)
{
    Vector v = { 0.0, 0.0 };
    double const rho = 1.0;

    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    // Apply Poiseuille distribution for all nodes except on top/bottom border
    for (size_t i = 0; i < mesh->width; i++) {
        for (size_t j = 0; j < mesh->height; j++) {
            for (size_t k = 0; k < DIRECTIONS; k++) {
                // Compute equilibrium
                v[0] = helper_compute_poiseuille(j + mesh_comm->y, MESH_HEIGHT);
                lbm_mesh_cell_t cell = Mesh_get_cell(mesh, i, j);
                cell[k] = compute_equilibrium_profile(v, rho, k);
                // Mark as standard fluid
                *(lbm_cell_type_t_get_cell(mesh_type, i, j)) = CELL_FUILD;
                // This is a try to init the fluid with a null speed except on
                // the left border.
                // if (i > 1) {
                //     Mesh_get_cell(mesh, i, j)[k] = equil_weight[k];
                // }
            }
        }
    }
}

void setup_init_state_border(Mesh* mesh, lbm_mesh_type_t* mesh_type,
                             lbm_comm_t const* mesh_comm)
{
    Vector v = { 0.0, 0.0 };
    double const rho = 1.0;

    // Setup left border type
    if (mesh_comm->left_id == -1) {
        for (size_t j = 1; j < mesh->height - 1; j++) {
            *(lbm_cell_type_t_get_cell(mesh_type, 0, j)) = CELL_LEFT_IN;
        }
    }

    // Setup right border type
    if (mesh_comm->right_id == -1) {
        for (size_t j = 1; j < mesh->height - 1; j++) {
            *(lbm_cell_type_t_get_cell(mesh_type, mesh->width - 1, j)) = CELL_RIGHT_OUT;
        }
    }

    // Setup top border type
    if (mesh_comm->top_id == -1) {
        for (size_t i = 0; i < mesh->width; i++) {
            for (size_t k = 0; k < DIRECTIONS; k++) {
                // Compute equilibrium.
                Mesh_get_cell(mesh, i, 0)[k] =
                    compute_equilibrium_profile(v, rho, k);
                // Mark as bounce back
                *(lbm_cell_type_t_get_cell(mesh_type, i, 0)) = CELL_BOUNCE_BACK;
            }
        }
    }

    // Setup bottom border type
    if (mesh_comm->bottom_id == -1) {
        for (size_t i = 0; i < mesh->width; i++) {
            for (size_t k = 0; k < DIRECTIONS; k++) {
                // Compute equilibrium.
                Mesh_get_cell(mesh, i, mesh->height - 1)[k] =
                    compute_equilibrium_profile(v, rho, k);
                // Mark as bounce back
                *(lbm_cell_type_t_get_cell(mesh_type, i, mesh->height - 1)) = CELL_BOUNCE_BACK;
            }
        }
    }
}

void setup_init_state(Mesh* mesh, lbm_mesh_type_t* mesh_type,
                      lbm_comm_t const* mesh_comm)
{
    setup_init_state_global_poiseuille_profile(mesh, mesh_type, mesh_comm);
    setup_init_state_border(mesh, mesh_type, mesh_comm);
    setup_init_state_circle_obstacle(mesh, mesh_type, mesh_comm);
}
