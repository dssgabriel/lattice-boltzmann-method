#ifndef LBM_STRUCT_H
#define LBM_STRUCT_H

#include "lbm_config.h"

#include <stdint.h>
#include <stdio.h>

/// A cell is an array of double `DIRECTIONS` to store microscopic
/// probabilities (`f_i`).
typedef double* lbm_mesh_cell_t;

/// Representation of a vector to manipulate macroscopic velocities.
typedef double Vector[DIMENSIONS];

/**
 * @brief Defines a mesh for the local domain. This mesh contains a border for
 * phantom meshes of a cell.
 **/
typedef struct Mesh {
    /// Cells of a mesh of dimension `MESH_WIDTH` * `MESH_HEIGHT`.
    lbm_mesh_cell_t cells;
    /// Width of the local mesh (phantom meshes included).
    uint32_t width;
    /// Height of the local mesh (phantom meshes included).
    uint32_t height;
} Mesh;

/**
 * @brief Cell types definitions in order to know which process to apply when
 * computing.
 **/
typedef enum lbm_cell_type_e {
    /// Standard fluid cell. Applies to collisions.
    CELL_FUILD,
    /// Obstacle of top/bottom border cell. Applies to reflexions.
    CELL_BOUNCE_BACK,
    /// In-border cell. Applies to `Zou/He` with fixed `V`.
    CELL_LEFT_IN,
    /// Out-border cell. Applies to `Zou/He` with constant density gradiant.
    CELL_RIGHT_OUT
} lbm_cell_type_t;

/**
 * @brief Array storing the information on the types of cells.
 **/
typedef struct lbm_mesh_type_s {
    /// Mesh's types of cells of dimension `MESH_WIDTH` * `MESH_HEIGHT`.
    lbm_cell_type_t* types;
    /// Width of the local mesh (phantom meshes included).
    uint32_t width;
    /// Height of the local mesh (phantom meshes included).
    uint32_t height;
} lbm_mesh_type_t;

/**
 * @brief Header structure for the header of the output file.
 **/
typedef struct lbm_file_header_s {
    /// For validating the format of the file.
    uint32_t magick;
    /// Total width of the simulated mesh (phantom meshes included).
    uint32_t mesh_width;
    /// Total height of the simulated mesh (phantom meshes included).
    uint32_t mesh_height;
    /// Number of vertical lines.
    uint32_t lines;
} lbm_file_header_t;

/**
 * @brief An entry of the file with both macroscopic quantities.
 **/
typedef struct lbm_file_entry_s {
    /// Velocity.
    float v;
    /// Density.
    float rho;
} lbm_file_entry_t;

/**
 * @brief Structure to read the output file.
 **/
typedef struct lbm_data_file_s {
    FILE* fp;
    lbm_file_header_t header;
    lbm_file_entry_t* entries;
} lbm_data_file_t;

/**
 * @brief Initializes the local mesh.
 *
 * @param mesh Mesh to initialize.
 * @param width Width of the mesh (phantom meshes included).
 * @param height Height of the mesh (phantom meshes included).
 **/
void Mesh_init(Mesh* mesh, uint32_t width, uint32_t height);

/**
 * @brief Frees the memory of a mesh.
 **/
void Mesh_release(Mesh* mesh);

/**
 * @brief Initializes the local mesh type.
 *
 * @param mesh Mesh type to initialize.
 * @param width Width of the mesh (phantom meshes included).
 * @param height Height of the mesh (phantom meshes included).
 **/
void lbm_mesh_type_t_init(lbm_mesh_type_t* mesh, uint32_t width,
                          uint32_t height);

/**
 * Frees the memory of a mesh.
 **/
void lbm_mesh_type_t_release(lbm_mesh_type_t* mesh);

void save_frame(FILE* fp, Mesh const* mesh);

/**
 * @brief Prints a fatal error message.
 **/
void fatal(char const* message);

/**
 * @brief Retrieves a cell of a mesh given its coordinates.
 **/
static inline lbm_mesh_cell_t Mesh_get_cell(const Mesh* mesh, int x, int y)
{
    return &mesh->cells[(x * mesh->height + y) * DIRECTIONS];
}

/**
 * @brief Retrieves a column of a mesh given the `x` coordinate.
 **/
static inline lbm_mesh_cell_t Mesh_get_col(const Mesh* mesh, int x)
{
    // `+ DIRECTIONS` to skip the first (phantom) line
    return &mesh->cells[x * mesh->height * DIRECTIONS + DIRECTIONS];
}

/**
 * @brief Retrieves a pointer on the cell type of a mesh given its coordinates.
 **/
static inline lbm_cell_type_t*
lbm_cell_type_t_get_cell(lbm_mesh_type_t const* meshtype, uint32_t x, uint32_t y)
{
    return &meshtype->types[x * meshtype->height + y];
}

#endif // LBM_STRUCT_H
