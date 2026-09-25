cmake_minimum_required(VERSION 4.1)


project(parallelize Fortran)

find_package(OpenMP REQUIRED COMPONENTS Fortran)

add_executable(${PROJECT_NAME}
        loops.f90
        main.f90)

target_link_libraries(${PROJECT_NAME} PRIVATE OpenMP::OpenMP_Fortran)
target_compile_options(${PROJECT_NAME} PRIVATE
        -flto
        -ftree-parallelize-loops=10
)