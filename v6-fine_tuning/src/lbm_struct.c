#include "lbm_struct.h"

#include <stdlib.h>

void Mesh_init(Mesh* mesh, uint32_t width, uint32_t height)
{
    // Setup parameters
    mesh->width = width;
    mesh->height = height;

    // Allocate memory for cells
    mesh->cells = malloc(width * height * DIRECTIONS * sizeof(double));
    if (mesh->cells == NULL) {
        perror("malloc");
        abort();
    }
}

void Mesh_release(Mesh* mesh)
{
    mesh->width = 0;
    mesh->height = 0;
    free(mesh->cells);
}

void lbm_mesh_type_t_init(lbm_mesh_type_t* meshtype, uint32_t width,
                          uint32_t height)
{
    // Setup parameters
    meshtype->width = width;
    meshtype->height = height;

    // Allocate memory for cells
    meshtype->types = malloc((width + 2) * height * sizeof(lbm_cell_type_t));
    if (meshtype->types == NULL) {
        perror("malloc");
        abort();
    }
}

void lbm_mesh_type_t_release(lbm_mesh_type_t* mesh)
{
    mesh->width = 0;
    mesh->height = 0;
    free(mesh->types);
}

void fatal(char const* message)
{
    fprintf(stderr, "FATAL ERROR : %s\n", message);
    abort();
}
