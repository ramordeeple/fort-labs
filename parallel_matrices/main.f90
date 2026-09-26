program parallel_matrices
    use matrix_module
    use omp_lib

    real(precision) :: temp(N)
    real(precision) :: s

    call init_matrices()

    write (*, '(A, F10.3)') "A = ", A(1,1)
    write (*, '(A, F10.3)') "B = ", B(1,1)
    write (*, '(A, F10.3)') "C = ", C(1,1)
    write (*, *)

    t1 = omp_get_wtime()

    do i = 1, N
        do j = 1, N
            do k = 1, N
                C(i,j) = C(i,j) + A(i,k) * B(k,j)
            end do
        end do
    end do

    t2 = omp_get_wtime()

    write (*, *) "DO"
    write (*, '(A, F10.3)') "C(1,1) = ", C(1,1)
    write (*, '(A, F10.5)') "TIME = ", t2 - t1
    write (*, *)


    ! ===================== !

    C = 0.0
    t1 = omp_get_wtime()

    do concurrent (i = 1:N)
        do j = 1, N
            do k = 1, N
                C(i,j) = C(i,j) + A(i,k) * B(k,j)
            end do
        end do
    end do

    t2 = omp_get_wtime()

    write (*, *) "DO CONCURRENT внешний"
    write (*, '(A, F10.3)') "C(1,1) = ", C(1,1)
    write (*, '(A, F10.5)') "TIME = ", t2 - t1
    write (*, *)

    ! ===================== !

    C = 0.0
    t1 = omp_get_wtime()

    !$omp parallel do private(j, k)
    do i = 1, N
        do j = 1, N
            do k = 1, N
                C(i,j) = C(i,j) + A(i,k) * B(k,j)
            end do
        end do
    end do
    !$omp end parallel do

    t2 = omp_get_wtime()

    write (*, *) "OPENMP внешний"
    write (*, '(A, F10.3)') "C(1,1) = ", C(1,1)
    write (*, '(A, F10.5)') "TIME = ", t2 - t1
    write (*, *)

    ! ===================== !

    C = 0.0
    t1 = omp_get_wtime()

    do i = 1, N

        do concurrent (j = 1:N)
            do k = 1, N
                C(i,j) = C(i,j) + A(i,k) * B(k,j)
            end do
        end do

    end do

    t2 = omp_get_wtime()

    write (*, *) "DO CONCURRENT средний"
    write (*, '(A, F10.3)') "C(1,1) = ", C(1,1)
    write (*, '(A, F10.5)') "TIME = ", t2 - t1
    write (*, *)

    ! ===================== !

    C = 0.0
    t1 = omp_get_wtime()

    do i = 1, N

        !$omp parallel do private(k)
        do j = 1, N
            do k = 1, N
                C(i,j) = C(i,j) + A(i,k) * B(k,j)
            end do
        end do
        !$omp end parallel do

    end do

    t2 = omp_get_wtime()

    write (*, *) "OPENMP средний"
    write (*, '(A, F10.3)') "C(1,1) = ", C(1,1)
    write (*, '(A, F10.5)') "TIME = ", t2 - t1
    write (*, *)

    ! ===================== !

    C = 0.0
    t1 = omp_get_wtime()

    do i = 1, N
        do j = 1, N

            do concurrent (k = 1:N)
                temp(k) = A(i,k) * B(k,j)
            end do

            C(i,j) = sum(temp)

        end do
    end do

    t2 = omp_get_wtime()

    write (*, *) "DO CONCURRENT внутренний"
    write (*, '(A, F10.3)') "C(1,1) = ", C(1,1)
    write (*, '(A, F10.5)') "TIME = ", t2 - t1
    write (*, *)

    ! ===================== !

    C = 0.0
    t1 = omp_get_wtime()

    do i = 1, N
        do j = 1, N

            s = 0.0

            !$omp parallel do reduction(+:s)
            do k = 1, N
                s = s + A(i,k) * B(k,j)
            end do
            !$omp end parallel do

            C(i,j) = s

        end do
    end do

    t2 = omp_get_wtime()

    write (*, *) "OPENMP внутренний"
    write (*, '(A, F10.3)') "C(1,1) = ", C(1,1)
    write (*, '(A, F10.5)') "TIME = ", t2 - t1
    write (*, *)

end program
