#include "../include/lbm_config.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

lbm_config_t lbm_gbl_config;

/**
 * Application des valeurs par defaut au cas ou l'utilisateur en définirait pas
 * tout dans le fichier de configuration.
 **/
void setup_default_values(void)
{
    // Directisation
    lbm_gbl_config.iterations = 10000;
    lbm_gbl_config.width = 800;
    lbm_gbl_config.height = 100;
    // Obstacle
    lbm_gbl_config.obstacle_x = 0.0;
    lbm_gbl_config.obstacle_y = 0.0;
    lbm_gbl_config.obstacle_r = 0.0;
    // Flow
    lbm_gbl_config.inflow_max_velocity = 0.1;
    lbm_gbl_config.reynolds = 100;
    // Result output file
    lbm_gbl_config.output_filename = NULL;
    lbm_gbl_config.write_interval = 50;
}

/**
 * Calcul des paramètres dérivés.
 **/
void update_derived_parameter(void)
{
    // Derived parameter
    lbm_gbl_config.kinetic_viscosity =
        (lbm_gbl_config.inflow_max_velocity * 2.0 * lbm_gbl_config.obstacle_r /
         lbm_gbl_config.reynolds);
    lbm_gbl_config.relax_parameter =
        1.0 / (3.0 * lbm_gbl_config.kinetic_viscosity + 1.0 / 2.0);
}

/**
 * Chargement de la config depuis le fichier.
 **/
void load_config(const char* filename)
{
    // Vars
    FILE* fp;
    char buffer[1024];
    char buffer2[1024];
    int intValue;
    double doubleValue;
    int line = 0;

    // Open the config file
    fp = fopen(filename, "r");
    if (fp == NULL) {
        perror(filename);
        abort();
    }

    // Load default values
    setup_default_values();

    // Loop on lines
    while (fgets(buffer, 1024, fp) != NULL) {
        line++;
        if (buffer[0] == '#') {
            // Comment, nothing to do
        } else if (sscanf(buffer, "iterations = %d\n", &intValue) == 1) {
            lbm_gbl_config.iterations = intValue;
        } else if (sscanf(buffer, "width = %d\n", &intValue) == 1) {
            lbm_gbl_config.width = intValue;
            if (lbm_gbl_config.obstacle_x == 0.0) {
                lbm_gbl_config.obstacle_x = (lbm_gbl_config.width / 5.0 + 1.0);
            }
        } else if (sscanf(buffer, "height = %d\n", &intValue) == 1) {
            lbm_gbl_config.height = intValue;
            if (lbm_gbl_config.obstacle_y == 0.0) {
                lbm_gbl_config.obstacle_y = (lbm_gbl_config.height / 2.0 + 3.0);
                lbm_gbl_config.obstacle_r =
                    (lbm_gbl_config.height / 10.0 + 1.0);
            }
        } else if (sscanf(buffer, "obstacle_x = %lf\n", &doubleValue) == 1) {
            if (doubleValue != 0.0) {
                lbm_gbl_config.obstacle_x = doubleValue;
            }
        } else if (sscanf(buffer, "obstacle_y = %lf\n", &doubleValue) == 1) {
            if (doubleValue != 0.0) {
                lbm_gbl_config.obstacle_y = doubleValue;
            }
        } else if (sscanf(buffer, "obstacle_r = %lf\n", &doubleValue) == 1) {
            if (doubleValue != 0.0) {
                lbm_gbl_config.obstacle_r = doubleValue;
            }
        } else if (sscanf(buffer, "inflow_max_velocity = %lf\n", &doubleValue) == 1) {
            lbm_gbl_config.inflow_max_velocity = doubleValue;
        } else if (sscanf(buffer, "reynolds = %lf\n", &doubleValue) == 1) {
            lbm_gbl_config.reynolds = doubleValue;
        } else if (sscanf(buffer, "kinetic_viscosity = %lf\n", &doubleValue) == 1) {
            lbm_gbl_config.kinetic_viscosity = doubleValue;
        } else if (sscanf(buffer, "relax_parameter = %lf\n", &doubleValue) == 1) {
            lbm_gbl_config.relax_parameter = doubleValue;
        } else if (sscanf(buffer, "write_interval = %d\n", &intValue) == 1) {
            lbm_gbl_config.write_interval = intValue;
        } else if (sscanf(buffer, "output_filename = %s\n", buffer2) == 1) {
            lbm_gbl_config.output_filename = strdup(buffer2);
        } else {
            fprintf(stderr, "Invalid config option line %d: %s\n", line, buffer);
            abort();
        }
    }

    // Check error
    if (!feof(fp)) {
        perror(filename);
        abort();
    }

    update_derived_parameter();
}

/**
 * Nettoyage de la mémoire dynamique de la config.
 **/
void config_cleanup(void)
{
    free((void*)lbm_gbl_config.output_filename);
}

/**
 * Affichage de la config.
 **/
void print_config(void)
{
    printf("=================== CONFIG ===================\n"
           "%-20s = %d\n"
           "%-20s = %d\n"
           "%-20s = %d\n"
           "%-20s = %lf\n"
           "%-20s = %lf\n"
           "%-20s = %lf\n"
           "%-20s = %lf\n"
           "%-20s = %lf\n"
           "%-20s = %s\n"
           "%-20s = %d\n"
           "------------ Derived parameters --------------\n"
           "%-20s = %lf\n"
           "%-20s = %lf\n"
           "==============================================\n",
           "iterations", lbm_gbl_config.iterations,
           "width", lbm_gbl_config.width,
           "height", lbm_gbl_config.height,
           "obstacle x coord", lbm_gbl_config.obstacle_x,
           "obstacle y coord", lbm_gbl_config.obstacle_y,
           "obstacle radius", lbm_gbl_config.obstacle_r,
           "reynolds number", lbm_gbl_config.reynolds,
           "inflow max velocity", lbm_gbl_config.inflow_max_velocity,
           "output filename", lbm_gbl_config.output_filename,
           "write interval", lbm_gbl_config.write_interval,
           "kinetic viscosity", lbm_gbl_config.kinetic_viscosity,
           "relax parameter", lbm_gbl_config.relax_parameter);
}
