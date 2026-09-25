module loops
    INTEGER, PARAMETER                :: N = 5000, KR = SELECTED_REAL_KIND(10,30)
    INTEGER                           :: I,J
    REAL(KIND=KR), DIMENSION(N,N)     :: A, B, C

CONTAINS
    SUBROUTINE DATA_INIT(IOUT)
        use omp_lib
        INTEGER, INTENT(IN) :: IOUT
        integer :: IRET = 0
        !        DO I=1, N
        !            DO J = 1, N
        !                A(I,J) = 1.0
        !                B(I,J) = 2.0
        !                C(I,J) = 0.0
        !            ENDDO
        !        ENDDO

        !omp parallel

        !$OMP WORKSHARE
        A = 1.0
        !$OMP END WORKSHARE

        !$OMP WORKSHARE
        B = 2.0
        !$OMP END WORKSHARE

        !$OMP WORKSHARE
        C = 0.0
        !$OMP END WORKSHARE

        !$OMP END PARALLEL

    END SUBROUTINE DATA_INIT
end module loops
