# Lattice Boltzmann method - Optimization techniques project

## Introduction and description of the project
The aim of this project is to optimize a numerical simulation of _Computational
Fluid Dynamics_ (CFD) and to make it as scalable as possible. The base code is
voluntarily "unoptomized" and contains errors that will need to be fixed through
the use of debugging tools like GDB or Valgrind. Afterwards, the goal will be to
identify and remove the different contentions in the program in order to achieve
peak performance. To that extent, we shall use tracing and profiling tools such
as MAQAO, Tau or Interpol. These will help us modify the base implementation
and obtain a hybrid code that uses both MPI and multi-threading (e.g. through
automatic parallelization with OpenMP).

The provided code aims at simulating a Karman vortex street. We consider a fluid
flowing down a 2D tube in which we place a round-shaped obstacle. This simulates,
in principle, the setup we would have in a wind tunnel. As for the resolution, we
use the Lattice Boltzmann Method (LBM), a relatively recent technique which
consists in replacing the Navier-Stokes equations with a discretization of the
Boltzmann equation in order to simulate the complex behavior of fluids using
streaming and collision (relaxation) processes. This method is particularly well-
suited for use in High Performance Computing (HPC) as it is highly parallelizable,
which efficiently leverages the architecture of modern multi-core CPUs (Central
Processing Units) and GPGPUs (General Purpose Graphical Processing Units).

## Installation
### Dependencies
The following dependencies are needed to run the programs:
- an MPI implementation and its patched C compiler (tested with OpenMPI v4.1.2, MPICH v4.0.2 and MPC v4.1.0);
- GNU Make

### Building
Start by cloning this repository locally:
```
git clone https://github.com/dssgabriel/lattice-boltzmann-method.git
```

The directory is composed of several sub-directories, each containing an improved version of the simulation.
Inside these, simply use the provided Makefiles to compile and/or run the programs:
```
make build
make run
```
Other subcommands are available in the Makefiles, such as `make gif` which generates a GIF of the simulation.
> Note: the `make trace` command requires you to have the [Interpol profiler][https://github.com/async-mpi-benchmarks/interpol] installed on your machine.
