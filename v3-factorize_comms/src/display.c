#include "../include/lbm_struct.h"

#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

typedef enum lbm_output_format_e {
    OUT_FORMAT_GNUPLOT,
    OUT_FORMAT_OCTAVE,
    OUT_FORMAT_CHECKSUM,
    OUT_FORMAT_INFO
} lbm_output_format_t;

void fatal(const char* message)
{
    fprintf(stderr, "\033[1;31mfatal:\033[0m %s\n", message);
    abort();
}

void open_data_file(lbm_data_file_t* file, const char* fname)
{
    assert(file != NULL);
    assert(fname != NULL);

    file->fp = fopen(fname, "rb");
    if (file->fp == NULL) {
        perror(fname);
        abort();
    }

    // Read header
    if (!fread(&file->header, sizeof(file->header), 1, file->fp)) {
        if (ferror(file->fp)) {
            perror("fread");
            abort();
        }
        if (feof(file->fp)) {
            fatal("file is empty");
        }
    }

    // Check magick
    if (file->header.magick != RESULT_MAGICK)
        fatal("invalid file format");

    // Allocate memory
    file->entries = malloc(file->header.mesh_height * file->header.mesh_width *
                           sizeof(lbm_file_entry_t));
}

void close_data_file(lbm_data_file_t* file)
{
    assert(file != NULL);
    assert(file->fp != NULL);
    assert(file->entries != NULL);

    fclose(file->fp);
    free(file->entries);
}

bool read_next_frame(lbm_data_file_t* file)
{
    assert(file != NULL);
    assert(file->fp != NULL);
    assert(file->entries != NULL);

    // Load the frame
    size_t res =
        fread(file->entries, sizeof(lbm_file_entry_t),
              file->header.mesh_height * file->header.mesh_width, file->fp);

    if (res != file->header.mesh_height * file->header.mesh_width) {
        if (feof(file->fp)) {
            return false;
        } else {
            fatal("failed to read file");
            return false;
        }
    } else {
        return true;
    }
}

bool seek_to_frame(lbm_data_file_t* file, int frame)
{
    int res = fseek(file->fp,
                    frame * sizeof(lbm_file_entry_t) *
                        file->header.mesh_height * file->header.mesh_width,
                    SEEK_CUR);
    return (res == 0);
}

void print_current_frame_gnuplot(lbm_data_file_t* file)
{
    // Calc line_height
    uint32_t line_height = file->header.mesh_height / file->header.lines;

    // Loop on datas
    for (size_t i = 0; i < file->header.mesh_width; i++) {
        for (size_t l = 0; l < file->header.lines; l++) {
            for (size_t j = 0; j < line_height; j++) {
                size_t pos = line_height * i + j +
                             l * line_height * file->header.mesh_width;
                printf("%zu %zu %f %f\n", i, j + l * line_height,
                       file->entries[pos].rho, file->entries[pos].v);
            }
        }
        printf("\n");
    }
    printf("\n");
}

double checksum = 0;

void do_checksum(lbm_data_file_t* file)
{
    // Loop on datas
    for (size_t i = 0; i < file->header.mesh_width; i++) {
        for (size_t j = 0; j < file->header.mesh_height; j++) {
            size_t pos = file->header.mesh_height * i + j;
            checksum += file->entries[pos].rho + file->entries[pos].v;
        }
    }

    printf("%lX - %g\n", (uint64_t)checksum, checksum);
}

int get_frame_count(lbm_data_file_t* file)
{
    struct stat info;
    if (fstat(fileno(file->fp), &info) == 0) {
        return info.st_size /
               (file->header.mesh_width * file->header.mesh_height *
                sizeof(lbm_file_entry_t));
    } else {
        return 0;
    }
}

void print_info(lbm_data_file_t* file)
{
    printf("width  = %d\n", file->header.mesh_width);
    printf("height = %d\n", file->header.mesh_height);
    printf("frames = %d\n", get_frame_count(file));
}

void print_current_frame(lbm_data_file_t* file, lbm_output_format_t format)
{
    switch (format) {
        case OUT_FORMAT_GNUPLOT:
            print_current_frame_gnuplot(file);
            break;
        case OUT_FORMAT_OCTAVE:
            printf("Unimplemented\n");
            abort();
            break;
        case OUT_FORMAT_INFO:
            print_info(file);
            break;
        case OUT_FORMAT_CHECKSUM:
            do_checksum(file);
            break;
    }
}

void print_data(lbm_data_file_t* file, lbm_output_format_t format, int frame)
{
    assert(file != NULL);
    assert(frame >= 0);

    // Seek to frame
    if (seek_to_frame(file, frame) == false)
        fatal("failed to seek to the requested frame.");
    // Read
    if (read_next_frame(file))
        print_current_frame(file, format);
}

int main(int argc, char* argv[])
{
    // Vars
    lbm_data_file_t file;
    lbm_output_format_t format;
    int frame = -1;

    // Arg error
    if (argc != 4) {
        fprintf(stderr,
                "Usage: %s --<gnuplot|octave|checksum|info> <file.raw> "
                "<frame_id>\n",
                argv[0]);
        abort();
    }

    open_data_file(&file, argv[2]);
    frame = atoi(argv[3]);

    // Read args
    if (strcmp(argv[1], "--gnuplot") == 0) {
        format = OUT_FORMAT_GNUPLOT;
    } else if (strcmp(argv[1], "--checksum") == 0) {
        format = OUT_FORMAT_CHECKSUM;
    } else if (strcmp(argv[1], "--info") == 0) {
        format = OUT_FORMAT_INFO;
    } else {
        fatal("invalid format option");
    }

    print_data(&file, format, frame);
    close_data_file(&file);

    return EXIT_SUCCESS;
}
