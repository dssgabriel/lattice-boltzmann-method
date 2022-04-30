#ifndef LBM_PHYS_H
#define LBM_PHYS_H

#include "lbm_comm.h"
#include "lbm_struct.h"

extern double const equil_weight[DIRECTIONS];

/** ------------------------------------------------------------------------ **
 * Helper functions                                                           *
 ** ------------------------------------------------------------------------ **/

/**
 * @brief Computes the product of two vectors.
 *
 * @param a First vector.
 * @param b Second vector.
 * @return Product of both vectors.
 **/
double get_vect_norm_2(Vector const a, Vector const b);

/**
 * @brief Computes the macroscopic density of the cell by summing its
 *`DIRECTIONS` microscopic densities.
 *
 * @param Cell to compute the density of.
 * @return Macroscopic density of the cell.
 **/
double get_cell_density(lbm_mesh_cell_t const cell);

/**
 * @brief Computes the macroscopic velocity of the cell by summing its
 *`DIRECTIONS` microscopic velocities.
 *
 * @param Cell to compute the velocity of.
 * @param cell_density Macroscopic density of the cell.
 * @return Macroscopic velocity of the cell.
 **/
void get_cell_velocity(Vector v, lbm_mesh_cell_t const cell,
                       double cell_density);

/**
 * @brief Provides the velocity of Poiseuille for a given position considering
 * a tube of given size.
 *
 * @param i Position in which we search the velocity.
 * @param size Diameter of the tube.
 * @return Velocity of Poiseuille.
 **/
double helper_compute_poiseuille(size_t const i, size_t const size);

/** ------------------------------------------------------------------------ **
 * Collision functions                                                        *
 ** ------------------------------------------------------------------------ **/

/**
 * @brief Computes microscopic density profile at equilibrium for a given
 * direction.
 *
 * A derivative of the Navier-Stokes equations is used here.
 *
 * @param velocity Fluid's macroscopic velocity on the mesh.
 * @param density Fluid's macroscopic density on the mesh.
 * @param direction Direction in which to compute the state of equilibrium.
 * @return Microscopic density profile at equilibrium.
 **/
double compute_equilibrium_profile(Vector velocity, double density,
                                   int direction);

/**
 * @brief Computes the collision vector between fluids in every direction.
 *
 * @param cell_out Cell after collision.
 * @param cell_in Cell before collision.
 **/
void compute_cell_collision(lbm_mesh_cell_t cell_out,
                            lbm_mesh_cell_t const cell_in);

/** ------------------------------------------------------------------------ **
 * Limit conditions                                                           *
 ** ------------------------------------------------------------------------ **/

/**
 * @brief Applies a reflexion on the different directions to simulate the
 * presence of a solid body.
 *
 * @param The cell to compute the bounce back on.
 **/
void compute_bounce_back(lbm_mesh_cell_t cell);

/**
 * @brief Applies the Zou/He method to simulate a fluid entering the domain
 * from left to right on a vertical border. The velocity profile of the
 * entering fluid follows a Poiseuille distribution.
 *
 * @param mesh The given mesh (mainly for the height).
 * @param cell Mesh to update.
 * @param id_y Y position of the cell in order to know how to compute
 * Poiseuille velocity.
 **/
void compute_inflow_zou_he_poiseuille_distr(Mesh const* mesh,
                                            lbm_mesh_cell_t cell, size_t id_y);

/**
 * @brief Applies the Zou/He method to simulate a fluid leaving the domain from
 * left to right on a vertical border. The condition applied to build the
 * equation is the the maintaining of a gradiant of null density at the border.
 * 
 * @param cell Mesh to update.
 **/
void compute_outflow_zou_he_const_density(lbm_mesh_cell_t mesh);

/** ------------------------------------------------------------------------ **
 * Main functions                                                             *
 ** ------------------------------------------------------------------------ **/

/**
 * @brief Applies the special actions linked to the conditions at the borders
 * or at the obstacle reflexions.
 * 
 * @param mesh The mesh to apply the special actions to.
 * @param mesh_type The information grid denotating the type of mesh.
 * @param mesh_comm The communication structure to determine the absolute
 * position in the global mesh.
 **/
void special_cells(Mesh* mesh, lbm_mesh_type_t* mesh_type,
                   lbm_comm_t const* mesh_comm);

/**
 * @brief Computes the collisions on each cell.
 * 
 * @param mesh_out Mesh before special actions.
 * @param mesh_in after special actions.
 **/
void collision(Mesh* mesh_out, Mesh const* mesh_in);

/**
 * @brief Propagate the densities on the neighboor meshes.
 * 
 * @param mesh_out Output mesh.
 * @param mesh_in Input mesh (cannot be the same).
 **/
void propagation(Mesh* mesh_out, Mesh const* mesh_in);

#endif // LBM_PHYS_H
