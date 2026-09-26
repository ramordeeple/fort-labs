PROGRAM parallelize
    USE LOOPS
    USE OMP_LIB

    IMPLICIT NONE
    INTEGER :: NP, IOUT = 1, IDX
    REAL(KIND=KR), PARAMETER  :: K = 3.1415
    REAL                      :: TM(2)

    CALL DATA_INIT(IOUT)

    !$omp parallel do private(I, J)
    DO I = 1, N
        DO J = 1, N
            C(I,J) = A(I,J)**K + B(I,J)**K
        ENDDO
    ENDDO
    !$omp end parallel do

    write (*, *) "C(1,1) = ", C(1,1)
    write (*, *) "C(2,2) = ", C(2,2)
    write (*, *) "C(N,N) = ", C(N,N)

END PROGRAM parallelize
