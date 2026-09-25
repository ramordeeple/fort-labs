cmake_minimum_required(VERSION 4.1)
project(findpinum Fortran)

find_package(OpenMP REQUIRED COMPONENTS Fortran)

add_executable(${PROJECT_NAME} main.f90 module.f90)

target_link_libraries(${PROJECT_NAME} PRIVATE OpenMP::OpenMP_Fortran)
target_compile_options(${PROJECT_NAME} PRIVATE
        -flto
        -ftree-parallelize-loops=10
)