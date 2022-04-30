#include "lbm_comm.h"

#include <assert.h>
#include <math.h>
#include <omp.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int lbm_helper_pgcd(int a, int b)
{
    int c;
    while (b != 0) {
        c = a % b;
        a = b;
        b = c;
    }
    return a;
}

/**
 * @brief Displays the configuration of the `lbm_comm` for a given rank.
 *
 * @param mesh_comm Configuration to print.
 **/
void lbm_comm_print(lbm_comm_t const* mesh_comm)
{
    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    printf("\033[1mRank \033[33m%d\033[0m: L = %2d, R = %2d, T = %2d, B = %2d "
           "| CORNER: "
           "%2d, %2d, %2d, %2d | POS: %3d %3d (W = %3d, H = %3d)\n",
           rank, mesh_comm->left_id, mesh_comm->right_id, mesh_comm->top_id,
           mesh_comm->bottom_id, mesh_comm->corner_id[0],
           mesh_comm->corner_id[1], mesh_comm->corner_id[2],
           mesh_comm->corner_id[3], mesh_comm->x, mesh_comm->y,
           mesh_comm->width, mesh_comm->height);
}

int helper_get_rank_id(int nb_x, int nb_y, int rank_x, int rank_y)
{
    if ((rank_x < 0 || rank_x >= nb_x) || (rank_y < 0 || rank_y >= nb_y)) {
        return -1;
    }
    return (rank_x + rank_y * nb_x);
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
                   uint32_t width, uint32_t height)
{
    // Compute splitting
    // int nb_y = lbm_helper_pgcd(comm_size, width);
    // int nb_x = comm_size / nb_y;
    int nb_x = lbm_helper_pgcd(comm_size, height);
    int nb_y = comm_size / nb_x;

    assert(nb_x * nb_y == comm_size);
    if (height % nb_y != 0) {
        fatal("Can't get a 2D cut for current problem size and number of "
              "processes.");
    }

    // Compute current rank position (ID)
    int rank_x = rank % nb_x;
    int rank_y = rank / nb_x;

    // Setup nb
    mesh_comm->nb_x = nb_x;
    mesh_comm->nb_y = nb_y;

    // Setup size (+2 for ghost cells on border)
    mesh_comm->width = width / nb_x + 2;
    mesh_comm->height = height / nb_y + 2;

    // Setup position
    mesh_comm->x = rank_x * width / nb_x;
    mesh_comm->y = rank_y * height / nb_y;

    // Compute neighbour nodes id
    mesh_comm->left_id = helper_get_rank_id(nb_x, nb_y, rank_x - 1, rank_y);
    mesh_comm->right_id = helper_get_rank_id(nb_x, nb_y, rank_x + 1, rank_y);
    mesh_comm->top_id = helper_get_rank_id(nb_x, nb_y, rank_x, rank_y - 1);
    mesh_comm->bottom_id = helper_get_rank_id(nb_x, nb_y, rank_x, rank_y + 1);
    mesh_comm->corner_id[CORNER_TOP_LEFT] =
        helper_get_rank_id(nb_x, nb_y, rank_x - 1, rank_y - 1);
    mesh_comm->corner_id[CORNER_TOP_RIGHT] =
        helper_get_rank_id(nb_x, nb_y, rank_x + 1, rank_y - 1);
    mesh_comm->corner_id[CORNER_BOTTOM_LEFT] =
        helper_get_rank_id(nb_x, nb_y, rank_x - 1, rank_y + 1);
    mesh_comm->corner_id[CORNER_BOTTOM_RIGHT] =
        helper_get_rank_id(nb_x, nb_y, rank_x + 1, rank_y + 1);

    // If more than 1 on y, need transmission buffer
    if (nb_y > 1) {
        mesh_comm->buffer = malloc(sizeof(double) * DIRECTIONS * width / nb_x);
    } else {
        mesh_comm->buffer = NULL;
    }

// If debug print comm
#ifndef NDEBUG
    lbm_comm_print(mesh_comm);
#endif
}

/**
 * @brief Frees the memory of a `lbm_comm`.
 *
 * @param mesh_comm Mesh communicator to free.
 **/
void lbm_comm_release(lbm_comm_t* mesh_comm)
{
    mesh_comm->x = 0;
    mesh_comm->y = 0;
    mesh_comm->width = 0;
    mesh_comm->height = 0;
    mesh_comm->right_id = -1;
    mesh_comm->left_id = -1;
    if (mesh_comm->buffer != NULL) {
        free(mesh_comm->buffer);
    }
}

/**
 * @brief Start of the horizontal asynchronous communications.
 *
 * @param mesh_comm Mesh communicator to use.
 * @param mesh_to_process Mesh to use when exchanging phantom meshes.
 * @param target_rank Rank to communicate with.
 * @param x X coordinate to use.
 **/
void lbm_comm_sync_ghosts_horizontal(Mesh* mesh_to_process,
                                     lbm_comm_type_t comm_type, int target_rank,
                                     uint32_t x)
{
    // If target is -1, no comm
    if (target_rank == -1) {
        return;
    }

    MPI_Status status;
    switch (comm_type) {
        case COMM_SEND:
            MPI_Send(Mesh_get_col(mesh_to_process, x),
                     DIRECTIONS * (mesh_to_process->height - 2), MPI_DOUBLE,
                     target_rank, 0, MPI_COMM_WORLD);
            break;
        case COMM_RECV:
            MPI_Recv(Mesh_get_col(mesh_to_process, x),
                     DIRECTIONS * (mesh_to_process->height - 2), MPI_DOUBLE,
                     target_rank, 0, MPI_COMM_WORLD, &status);
            break;
        default:
            fatal("unknown type of communication");
    }
}

/**
 * @brief Start of the diagonal asynchronous communications.
 *
 * @param mesh_comm Mesh communicator to use.
 * @param mesh_to_process Mesh to use when exchanging phantom meshes.
 * @param target_rank Rank to communicate with.
 * @param x X coordinate to use.
 * @param y Y coordinate to use.
 **/
void lbm_comm_sync_ghosts_diagonal(Mesh* mesh_to_process,
                                   lbm_comm_type_t comm_type, int target_rank,
                                   uint32_t x, uint32_t y)
{
    // If target is -1, no comm
    if (target_rank == -1) {
        return;
    }

    MPI_Status status;
    switch (comm_type) {
        case COMM_SEND:
            MPI_Send(Mesh_get_cell(mesh_to_process, x, y), DIRECTIONS,
                     MPI_DOUBLE, target_rank, 0, MPI_COMM_WORLD);
            break;
        case COMM_RECV:
            MPI_Recv(Mesh_get_cell(mesh_to_process, x, y), DIRECTIONS,
                     MPI_DOUBLE, target_rank, 0, MPI_COMM_WORLD, &status);
            break;
        default:
            fatal("unknown type of communication");
    }
}

/**
 * @brief Start of the vertical asynchronous communications.
 *
 * @param mesh_comm Mesh communicator to use.
 * @param mesh_to_process Mesh to use when exchanging phantom meshes.
 * @param target_rank Rank to communicate with.
 * @param y Y coordinate to use.
 **/
void lbm_comm_sync_ghosts_vertical(lbm_comm_t* mesh, Mesh* mesh_to_process,
                                   lbm_comm_type_t comm_type, int target_rank,
                                   uint32_t y)
{
    // if target is -1, no comm
    if (target_rank == -1) {
        return;
    }

    MPI_Status status;
    switch (comm_type) {
        case COMM_SEND:
            //#pragma omp parallel for schedule(guided)
            for (size_t x = 1; x < mesh_to_process->width - 2; x++) {
                for (size_t k = 0; k < DIRECTIONS; k++) {
                    mesh->buffer[(x - 1) * DIRECTIONS + k] =
                        Mesh_get_cell(mesh_to_process, x, y)[k];
                }
            }
            MPI_Send(mesh->buffer, DIRECTIONS * (mesh_to_process->width - 2),
                     MPI_DOUBLE, target_rank, 0, MPI_COMM_WORLD);
            break;
        case COMM_RECV:
            MPI_Recv(mesh->buffer, DIRECTIONS * (mesh_to_process->width - 2),
                     MPI_DOUBLE, target_rank, 0, MPI_COMM_WORLD, &status);
            //#pragma omp parallel for schedule(guided)
            for (size_t x = 1; x < mesh_to_process->width - 2; x++) {
                for (size_t k = 0; k < DIRECTIONS; k++) {
                    Mesh_get_cell(mesh_to_process, x, y)[k] =
                        mesh->buffer[(x - 1) * DIRECTIONS + k];
                }
            }
            break;
        default:
            fatal("unknown type of communication");
    }
}

void lbm_comm_ghost_exchange(lbm_comm_t* mesh, Mesh* mesh_to_process)
{
    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    // Left to right phase
    lbm_comm_sync_ghosts_horizontal(mesh_to_process, COMM_SEND, mesh->right_id,
                                    mesh->width - 2);
    lbm_comm_sync_ghosts_horizontal(mesh_to_process, COMM_RECV, mesh->left_id,
                                    0);

    // Right to left phase
    lbm_comm_sync_ghosts_horizontal(mesh_to_process, COMM_SEND, mesh->left_id,
                                    1);
    lbm_comm_sync_ghosts_horizontal(mesh_to_process, COMM_RECV, mesh->right_id,
                                    mesh->width - 1);

    // // Top to bottom phase
    // lbm_comm_sync_ghosts_vertical(mesh, mesh_to_process, COMM_SEND,
    //                               mesh->bottom_id, mesh->height - 2);
    // lbm_comm_sync_ghosts_vertical(mesh, mesh_to_process, COMM_RECV,
    //                               mesh->top_id, 0);

    // // Bottom to top phase
    // lbm_comm_sync_ghosts_vertical(mesh, mesh_to_process, COMM_SEND,
    //                               mesh->top_id, 1);
    // lbm_comm_sync_ghosts_vertical(mesh, mesh_to_process, COMM_RECV,
    //                               mesh->bottom_id, mesh->height - 1);

    // // Top left phase
    // lbm_comm_sync_ghosts_diagonal(mesh_to_process, COMM_SEND,
    //                               mesh->corner_id[CORNER_TOP_LEFT], 1, 1);
    // lbm_comm_sync_ghosts_diagonal(mesh_to_process, COMM_RECV,
    //                               mesh->corner_id[CORNER_BOTTOM_RIGHT],
    //                               mesh->width - 1, mesh->height - 1);

    // // Bottom left phase
    // lbm_comm_sync_ghosts_diagonal(mesh_to_process, COMM_SEND,
    //                               mesh->corner_id[CORNER_BOTTOM_LEFT], 1,
    //                               mesh->height - 2);
    // lbm_comm_sync_ghosts_diagonal(mesh_to_process, COMM_RECV,
    //                               mesh->corner_id[CORNER_TOP_RIGHT],
    //                               mesh->width - 1, 0);

    // // Top right phase
    // lbm_comm_sync_ghosts_diagonal(mesh_to_process, COMM_SEND,
    //                               mesh->corner_id[CORNER_TOP_RIGHT],
    //                               mesh->width - 2, 1);
    // lbm_comm_sync_ghosts_diagonal(mesh_to_process, COMM_RECV,
    //                               mesh->corner_id[CORNER_BOTTOM_LEFT], 0,
    //                               mesh->height - 1);

    // // Bottom left phase
    // lbm_comm_sync_ghosts_diagonal(mesh_to_process, COMM_SEND,
    //                               mesh->corner_id[CORNER_BOTTOM_LEFT], 1,
    //                               mesh->height - 2);
    // lbm_comm_sync_ghosts_diagonal(mesh_to_process, COMM_RECV,
    //                               mesh->corner_id[CORNER_TOP_RIGHT],
    //                               mesh->width - 1, 0);

    // // Bottom right phase
    // lbm_comm_sync_ghosts_diagonal(mesh_to_process, COMM_SEND,
    //                               mesh->corner_id[CORNER_BOTTOM_RIGHT],
    //                               mesh->width - 2, mesh->height - 2);
    // lbm_comm_sync_ghosts_diagonal(mesh_to_process, COMM_RECV,
    //                               mesh->corner_id[CORNER_TOP_LEFT], 0, 0);
}

/**
 * Rendu du mesh en effectuant une réduction a 0
 * @param mesh_comm MeshComm à utiliser
 * @param temp Mesh a utiliser pour stocker les segments
 **/
void save_frame_all_domain(FILE* fp, Mesh* source_mesh, Mesh* temp)
{
    int comm_size, rank;
    MPI_Comm_size(MPI_COMM_WORLD, &comm_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    // If we have more than one process
    if (1 < comm_size) {
        if (rank == RANK_MASTER) {
            // Rank 0 renders its local Mesh
            save_frame(fp, source_mesh);
            // Rank 0 receives & render other processes meshes
            for (ssize_t i = 1; i < comm_size; i++) {
                MPI_Status status;
                MPI_Recv(temp->cells,
                         source_mesh->width * source_mesh->height * DIRECTIONS,
                         MPI_DOUBLE, i, 0, MPI_COMM_WORLD, &status);
                save_frame(fp, temp);
            }
        } else {
            // All other ranks send their local mesh
            MPI_Send(source_mesh->cells,
                     source_mesh->width * source_mesh->height * DIRECTIONS,
                     MPI_DOUBLE, RANK_MASTER, 0, MPI_COMM_WORLD);
        }
    } else {
        // Only 0 renders its local mesh
        save_frame(fp, source_mesh);
    }
}
