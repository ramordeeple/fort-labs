module matrix_module
    implicit none

    integer, parameter :: N = 1000
    integer, parameter :: precision = 8

    real(precision) :: A(N,N)
    real(precision) :: B(N,N)
    real(precision) :: C(N,N)

contains

    subroutine init_matrices()
        !$omp parallel

        !$omp workshare
        A = 1.0
        !$omp end workshare

        !$omp workshare
        B = 2.0
        !$omp end workshare

        !$omp workshare
        C = 0.0
        !$omp end workshare

        !$omp end parallel
    end subroutine init_matrices

end module matrix_module