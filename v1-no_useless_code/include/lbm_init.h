#ifndef LBM_INIT_H
#define LBM_INIT_H

#include "lbm_comm.h"
#include "lbm_struct.h"

/**
 * @brief Loads mesh with initial conditions of a fluid at rest.
 * Use only for tests while implementing.
 *
 * Initial conditions:
 * - velocity (`v`) = 0;
 * - density (`rho`) = 0.
 * Equation is:```
 *   f_equilibrium(x, t) = w_i * rho + rho * s_i(v(x, t))
 * ```
 * Here:
 * - `v` = 0 so `s_i` = 0;
 * - `rho` = 1, so keep only `w_i`.
 * Where `w_i` is the direction weight.
 *
 * @param mesh Mesh to initialize.
 **/
void init_cond_velocity_0_density_1(Mesh* mesh);

/**
 * @brief Initialization of the obstacle.
 * Each mesh type associated with the obstacle is switched to `CELL_BOUNCE_BACK`
 * 
 * The obstacle is a circle of center (`OBSTACLE_X`, `OBSTACLE_Y`) and of radius
 * `OBSTACLE_R`.
 * 
 * @param mesh The mesh to initialize.
 * @param mesh_type The information grid denotating the type of mesh.
 * @param mesh_comm The communication structure to determine the absolute
 * position in the global mesh.
 **/
void setup_init_state_circle_obstacle(Mesh* mesh, lbm_mesh_type_t* mesh_type,
                                      lbm_comm_t const* mesh_comm);

/**
 * @brief Initializes the entire fluid with a Poiseuille distribution
 * corresponding to a linear flow at equilibrium.
 * 
 * @param mesh The mesh to initialize.
 * @param mesh_type The information grid denotating the type of mesh.
 * @param mesh_comm The communication structure to determine the absolute
 * position in the global mesh.
 **/
void setup_init_state_global_poiseuille_profile(Mesh* mesh,
                                                lbm_mesh_type_t* mesh_type,
                                                lbm_comm_t const* mesh_comm);

/**
 * @brief Initializes the conditions at the borders.
 * 
 * @param mesh The mesh to initialize.
 * @param mesh_type The information grid denotating the type of mesh.
 * @param mesh_comm The communication structure to determine the absolute
 * position in the global mesh.
 **/
void setup_init_state_border(Mesh* mesh, lbm_mesh_type_t* mesh_type,
                             lbm_comm_t const* mesh_comm);

/**
 * @brief Sets up the initial conditions.
 * 
 * @param mesh The mesh to initialize.
 * @param mesh_type The information grid denotating the type of mesh.
 * @param mesh_comm The communication structure to determine the absolute
 * position in the global mesh.
 **/
void setup_init_state(Mesh* mesh, lbm_mesh_type_t* mesh_type,
                      lbm_comm_t const* mesh_comm);

#endif // LBM_INIT_H
