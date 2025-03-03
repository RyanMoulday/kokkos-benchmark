#!/bin/bash
cmake .
make release


echo Running matrix-free-kokkos on the GPU
./matrix-free-kokkos >> out.txt
echo Running matrix-based-petsc on the Host with $(nproc) cores
mpirun -n $(grep -m 1 "cpu cores" /proc/cpuinfo | tr -d -c 0-9) matrix-based-petsc >> out.txt
echo Running matrix-based-trilinos on the Host with $(nproc) cores
mpirun -n $(grep -m 1 "cpu cores" /proc/cpuinfo | tr -d -c 0-9) matrix-based-trilinos >> out.txt