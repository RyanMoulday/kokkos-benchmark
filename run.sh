#!/bin/bash
cmake .
make release


echo Running matrix-free-kokkos on the GPU
./matrix-free-kokkos 6 >> out.txt
./matrix-free-kokkos 7 >> out.txt
echo Running matrix-free-cpu on the CPU
mpirun -n $(grep -m 1 "cpu cores" /proc/cpuinfo | tr -d -c 0-9) ./matrix-free-cpu 6 >> out.txt
mpirun -n $(grep -m 1 "cpu cores" /proc/cpuinfo | tr -d -c 0-9) ./matrix-free-cpu 7 >> out.txt
echo Running matrix-based-petsc on the Host with $(nproc) cores
mpirun -n $(grep -m 1 "cpu cores" /proc/cpuinfo | tr -d -c 0-9) matrix-based-petsc 6 >> out.txt
mpirun -n $(grep -m 1 "cpu cores" /proc/cpuinfo | tr -d -c 0-9) matrix-based-petsc 7 >> out.txt
echo Running matrix-based-trilinos on the Host with $(nproc) cores
mpirun -n $(grep -m 1 "cpu cores" /proc/cpuinfo | tr -d -c 0-9) matrix-based-trilinos 6 >> out.txt
mpirun -n $(grep -m 1 "cpu cores" /proc/cpuinfo | tr -d -c 0-9) matrix-based-trilinos 7 >> out.txt