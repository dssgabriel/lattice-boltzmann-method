#include "../include/lbm_comm.h"
#include "../include/lbm_config.h"
#include "../include/lbm_init.h"
#include "../include/lbm_phys.h"
#include "../include/lbm_struct.h"

#include <assert.h>
#include <math.h>
#include <mpi.h>
#include <omp.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

/**
 * @brief Writes the output file's header.
 * It essentialy provides information on the size of the mesh.
 * 
 * @param fp File descriptor to write to.
 * @param mesh_comm Domain to save.
 **/
void write_file_header(FILE* fp, lbm_comm_t* mesh_comm)
{
    // Setup header values
    lbm_file_header_t header = {
        .magick = RESULT_MAGICK,
        .mesh_height = MESH_HEIGHT,
        .mesh_width = MESH_WIDTH,
        .lines = mesh_comm->nb_y,
    };

    // Write file
    fwrite(&header, sizeof(header), 1, fp);
}

/**
 * @brief Opens the output file's header in write mode.
 * 
 * @return File descriptor to write to. 
 **/
FILE* open_output_file()
{
    // No output if empty filename
    if (RESULT_FILENAME == NULL) {
        return NULL;
    }

    // Open result file
    FILE* fp = fopen(RESULT_FILENAME, "wb");
    if (fp == NULL) {
        perror(RESULT_FILENAME);
        abort();
    }

    return fp;
}

void close_file(FILE* fp)
{
    // Wait for all processes before closing
    // MPI_Barrier(MPI_COMM_WORLD);
    fclose(fp);
}

/**
 * @brief Saves the result of one step of computation.
 * 
 * This function can be called multiple times when a MPI save on multiple
 * processes happens (e.g. saving them one at a time on each domain).
 * Writes only velocities and macroscopic densities in the form of single
 * precision floating-point numbers.
 * 
 * @param fp File descriptor to write to.
 * @param mesh Domain to save.
 **/
void save_frame(FILE* fp, const Mesh* mesh)
{
    // Write buffer to write float instead of double
    lbm_file_entry_t buffer[WRITE_BUFFER_ENTRIES];
    Vector v;
    double density, norm;

    // Loop on all values
    size_t cnt = 0;
    for (size_t i = 1; i < mesh->width - 1; i++) {
        for (size_t j = 1; j < mesh->height - 1; j++) {
            // Compute macroscopic values
            density = get_cell_density(Mesh_get_cell(mesh, i, j));
            get_cell_velocity(v, Mesh_get_cell(mesh, i, j), density);
            norm = sqrt(get_vect_norm_2(v, v));

            // Fill buffer
            buffer[cnt].rho= density;
            buffer[cnt].v = norm;
            cnt++;
            assert(cnt <= WRITE_BUFFER_ENTRIES);

            // Flush buffer if full
            if (cnt == WRITE_BUFFER_ENTRIES) {
                fwrite(buffer, sizeof(lbm_file_entry_t), cnt, fp);
                cnt = 0;
            }
        }
    }

    // Final flush
    if (cnt != 0) {
        fwrite(buffer, sizeof(lbm_file_entry_t), cnt, fp);
    }
}

int main(int argc, char* argv[static argc + 1])
{
    // Init MPI, get current rank and communicator size.
    int rank, comm_size;
    int required = MPI_THREAD_MULTIPLE, provided;
    MPI_Init_thread(&argc, &argv, required, &provided);
    if (provided < required) {
        printf("\033[1;32mwarning:\033[0m provided thread level does not match required\n");
    }
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &comm_size);

    // Get config filename
    char* config_filename;
    if (argc >= 2) {
        config_filename = argv[1];
    } else {
        config_filename = "config.txt";
    }

    // Load config file and display it on master node
    load_config(config_filename);
    if (rank == RANK_MASTER) {
        print_config();
    }

    // Init structures, allocate memory...
    lbm_comm_t mesh_comm;
    lbm_comm_init(&mesh_comm, rank, comm_size, MESH_WIDTH, MESH_HEIGHT);

    Mesh mesh, temp, temp_render;
    Mesh_init(&mesh, lbm_comm_width(&mesh_comm), lbm_comm_height(&mesh_comm));
    Mesh_init(&temp, lbm_comm_width(&mesh_comm), lbm_comm_height(&mesh_comm));
    Mesh_init(&temp_render, lbm_comm_width(&mesh_comm),
              lbm_comm_height(&mesh_comm));

    lbm_mesh_type_t mesh_type;
    lbm_mesh_type_t_init(&mesh_type, lbm_comm_width(&mesh_comm),
                         lbm_comm_height(&mesh_comm));

    // Master open the output file
    FILE* fp = NULL;
    if (rank == RANK_MASTER) {
        fp = open_output_file();
        // Write header
        write_file_header(fp, &mesh_comm);
    }

    // Setup initial conditions on mesh
    setup_init_state(&mesh, &mesh_type, &mesh_comm);
    setup_init_state(&temp, &mesh_type, &mesh_comm);

    // Write initial condition in output file
    if (lbm_gbl_config.output_filename != NULL) {
        save_frame_all_domain(fp, &mesh, &temp_render);
    }

    // Barrier to wait for all processes before starting
    MPI_Barrier(MPI_COMM_WORLD);

    // Time steps
    for (ssize_t i = 1; i < ITERATIONS; i++) {
        // Print progress
        if (rank == RANK_MASTER) {
            printf("Progress [%5zu/%5d (%3.2f%%)]\r", i, ITERATIONS, (float)i / ITERATIONS * 100);
        }

        // Compute special actions (border, obstacle...)
        special_cells(&mesh, &mesh_type, &mesh_comm);
        // Need to wait all before doing next step
        MPI_Barrier(MPI_COMM_WORLD);

        // Compute collision term
        collision(&temp, &mesh);
        // Need to wait all before doing next step
        MPI_Barrier(MPI_COMM_WORLD);

        // Propagate values from node to neighboors
        lbm_comm_ghost_exchange(&mesh_comm, &temp);
        propagation(&mesh, &temp);
        // Need to wait all before doing next step
        MPI_Barrier(MPI_COMM_WORLD);

        // Save step
        if (i % WRITE_STEP_INTERVAL == 0 &&
            lbm_gbl_config.output_filename != NULL)
        {
            save_frame_all_domain(fp, &mesh, &temp_render);
        }
    }

    if (rank == RANK_MASTER && fp != NULL) {
        close_file(fp);
    }

    // Free memory
    lbm_comm_release(&mesh_comm);
    Mesh_release(&mesh);
    Mesh_release(&temp);
    Mesh_release(&temp_render);
    lbm_mesh_type_t_release(&mesh_type);

    // Close MPI
    MPI_Finalize();

    return EXIT_SUCCESS;
}
