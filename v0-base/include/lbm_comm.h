#ifndef MESH_COMM_H
#define MESH_COMM_H

#include "lbm_struct.h"

#include <mpi.h>
#include <stdlib.h>

/// Definition of the master's process ID.
#define RANK_MASTER 0

/**
 * @brief Definition of the different types of cell to know which process to
 * apply when computing.
 **/
typedef enum lbm_corner_pos_e {
    CORNER_TOP_LEFT = 0,
    CORNER_TOP_RIGHT = 1,
    CORNER_BOTTOM_LEFT = 2,
    CORNER_BOTTOM_RIGHT = 3,
} lbm_corner_pos_t;

/**
 * @brief Type of communication.
 **/
typedef enum lbm_comm_type_e {
    COMM_SEND,
    COMM_RECV
} lbm_comm_type_t;

/**
 * @brief Structure used to store information about the communications.
 **/
typedef struct lbm_comm_t_s {
    /// X position of the local mesh in the global one (origin).
    uint32_t x;
    /// Y position of the local mesh in the global one (origin).
    uint32_t y;
    /// Size of the local mesh.
    uint32_t width;
    uint32_t height;
    int nb_x;
    int nb_y;
    /// ID of the right neighboor, -1 if none.
    int right_id;
    /// ID of the left neighboor, -1 if none.
    int left_id;
    /// ID of the top neighboor, -1 if none.
    int top_id;
    /// ID of the bottom neighboor, -1 if none.
    int bottom_id;
    int corner_id[4];
    /// Async requests.
    MPI_Request requests[32];
    lbm_mesh_cell_t buffer;
} lbm_comm_t;

static inline int lbm_comm_width(lbm_comm_t const* mc)
{
    return mc->width;
}

static inline int lbm_comm_height(lbm_comm_t const* mc)
{
    return mc->height;
}

/**
 * @brief Initialize a `lbm_comm`:
 * - neighboors;
 * - size of the local mesh;
 * - relative position.
 *
 * @param mesh_comm Mesh communicator to initialize.
 * @param rank Rank asking the initialization.
 * @param comm_size Size of the communicator.
 * @param width Width of the mesh.
 * @param height Height of the mesh.
 **/
void lbm_comm_init(lbm_comm_t* mesh_comm, int rank, int comm_size,
                   uint32_t width, uint32_t height);

/**
 * @brief Releases the memory used by a `lib_comm_t`.
 * 
 * @param mesh Mesh to release.
 **/
void lbm_comm_release(lbm_comm_t* mesh);

/**
 * @brief Displays the configuration of the `lbm_comm` for a given rank.
 *
 * @param mesh_comm Configuration to print.
 **/
void lbm_comm_print(lbm_comm_t const* mesh_comm);

void lbm_comm_sync_ghosts_wait(lbm_comm_t* mesh);

void lbm_comm_ghost_exchange(lbm_comm_t* mesh, Mesh* mesh_to_process);

void save_frame_all_domain(FILE* fp, Mesh* source_mesh, Mesh* temp);

#endif
