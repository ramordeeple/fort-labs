cmake_minimum_required(VERSION 4.1)
project(parallelize Fortran)

find_package(OpenMP REQUIRED COMPONENTS Fortran)

add_executable(parallelize
        loops.f90
        main.f90)

target_link_libraries(parallelize PRIVATE OpenMP::OpenMP_Fortran)
