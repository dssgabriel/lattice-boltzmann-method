#include "lbm_comm.h"
#include "lbm_config.h"
#include "lbm_init.h"
#include "lbm_phys.h"
#include "lbm_struct.h"

#include <assert.h>
#include <math.h>
#include <mpi.h>
#include <omp.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/**
 * @brief Writes the output file's header.
 * It essentialy provides information on the size of the mesh.
 *
 * @param fp File descriptor to write to.
 * @param mesh_comm Domain to save.
 **/
static void write_file_header(FILE* fp, lbm_comm_t* mesh_comm)
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
static FILE* open_output_file()
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

static inline void close_file(FILE* fp)
{
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

    // Loop on all values
    size_t cnt = 0;
    for (size_t i = 1; i < mesh->width - 1; i++) {
        for (size_t j = 1; j < mesh->height - 1; j++) {
            // Compute macroscopic values
            double const density = get_cell_density(Mesh_get_cell(mesh, i, j));
            Vector v;
            get_cell_velocity(v, Mesh_get_cell(mesh, i, j), density);
            double const norm = sqrt(get_vect_norm_2(v, v));

            // Fill buffer
            buffer[cnt].rho = density;
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

static inline double elapsed(struct timespec const before,
                             struct timespec const after)
{
    return (after.tv_sec - before.tv_sec) +
           (after.tv_nsec - before.tv_nsec) / 1e9;
}

int main(int argc, char* argv[argc + 1])
{
    // Init MPI, get current rank and communicator size.
    MPI_Init(&argc, &argv);
    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    int comm_size;
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

    Mesh mesh;
    Mesh_init(&mesh, lbm_comm_width(&mesh_comm), lbm_comm_height(&mesh_comm));

    Mesh temp;
    Mesh_init(&temp, lbm_comm_width(&mesh_comm), lbm_comm_height(&mesh_comm));

    Mesh temp_render;
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
    if (rank == RANK_MASTER) {
        putc('\n', stdout);
    }

    struct timespec overall_before, overall_after;
    struct timespec loop_before, loop_after;
    double* loop_latencies = malloc(ITERATIONS * sizeof(double));

    clock_gettime(CLOCK_MONOTONIC_RAW, &overall_before);
    // Time steps
    for (ssize_t i = 1; i < ITERATIONS; i++) {
        clock_gettime(CLOCK_MONOTONIC_RAW, &loop_before);

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

#if defined(NO_IO)
        // Measure time
        clock_gettime(CLOCK_MONOTONIC_RAW, &loop_after);
        loop_latencies[i] = elapsed(loop_before, loop_after);
#endif

        // Save step
        if (i % WRITE_STEP_INTERVAL == 0 &&
            lbm_gbl_config.output_filename != NULL) {
            save_frame_all_domain(fp, &mesh, &temp_render);
        }

#if !defined(NO_IO)
        // Measure time
        clock_gettime(CLOCK_MONOTONIC_RAW, &loop_after);
        loop_latencies[i] = elapsed(loop_before, loop_after);
#endif
    }
    clock_gettime(CLOCK_MONOTONIC_RAW, &overall_after);
    double const local_latency = elapsed(overall_before, overall_after);

    MPI_Barrier(MPI_COMM_WORLD);
    double local_avg_loop_latency = 0.0;
    for (size_t i = 0; i < ITERATIONS; ++i) {
        local_avg_loop_latency += loop_latencies[i];
    }
    local_avg_loop_latency /= ITERATIONS;

    double global_avg_loop_latency, global_latency;
    MPI_Reduce(&local_avg_loop_latency, &global_avg_loop_latency, 1, MPI_DOUBLE,
               MPI_SUM, 0, MPI_COMM_WORLD);
    MPI_Reduce(&local_latency, &global_latency, 1, MPI_DOUBLE, MPI_SUM, 0,
               MPI_COMM_WORLD);

#if defined(NO_IO)
    printf("\033[1mRank \033[33m%d\033[0m: local average loop latency: "
           "\033[36m%.6lfms\033[0m    (I/Os not measured)\n",
           rank, local_avg_loop_latency * 1000.0);
#elif !defined(NO_IO)
    printf("\033[1mRank \033[33m%d\033[0m: local average loop latency: "
           "\033[36m%.6lfms\033[0m\n",
           rank, local_avg_loop_latency * 1000.0);
#endif
    printf("\033[1mRank \033[33m%d\033[0m: local simulation latency:   "
           "\033[36m%.9lfs\033[0m\n",
           rank, local_latency);

    if (rank == RANK_MASTER && fp != NULL) {
        close_file(fp);
    }

    if (rank == RANK_MASTER) {
#if defined(NO_IO)
        printf("\nGlobal average loop latency:        %.6lfms    (I/Os not measured)\n",
               global_avg_loop_latency / comm_size * 1000.0);
#elif !defined(NO_IO)
        printf("\nGlobal average loop latency:        %.6lfms\n",
               global_avg_loop_latency / comm_size * 1000.0);
#endif
        printf("Global simulation latency:          %.9lfs\n",
               global_latency / comm_size);
    }

    // Free memory
    free(loop_latencies);
    lbm_comm_release(&mesh_comm);
    Mesh_release(&mesh);
    Mesh_release(&temp);
    Mesh_release(&temp_render);
    lbm_mesh_type_t_release(&mesh_type);

    // Close MPI
    MPI_Finalize();

    return EXIT_SUCCESS;
}
