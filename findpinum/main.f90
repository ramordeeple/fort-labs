program main
    use omp_lib
    use module

    real(precision) :: local_s

    s = 0
    t1 = omp_get_wtime()

    do k = 0, NMAX - 1
        s = s + (-1.)**k / (2*k + 1)
    end do

    pi = 4 * s
    t2 = omp_get_wtime()

    write (*, *) "DO"
    write (*, *) "PI = ", pi
    write (*, '(A, F10.5)') "TIME = ", t2 - t1
    write (*, *)

    ! ===================== !

    s = 0
    t1 = omp_get_wtime()

    do concurrent (i = 1:NPARTS)
        part(i) = series(i)
    end do
    s = sum(part)

    pi = 4 * s

    t2 = omp_get_wtime()

    write (*, *) "DO CONCURRENT"
    write (*, *) "PI = ", pi
    write (*, '(A, F10.5)') "TIME = ", t2 - t1
    write (*, *)

    ! ===================== !

    s = 0
    t1 = omp_get_wtime()

    !$omp parallel do reduction(+:s)
    do k = 0, NMAX - 1
        s = s + (-1.)**k / (2*k + 1)
    end do
    !$omp end parallel do

    pi = 4 * s
    t2 = omp_get_wtime()

    write (*, *) "OPENMP"
    write (*, *) "PI   =", pi
    write (*, '(A, F10.5)') "TIME = ", t2 - t1
    write (*, *)

    ! ===================== !

    s = 0
    t1 = omp_get_wtime()

    !$omp parallel private(k, local_s)

    local_s = 0

    !$omp do
    do k = 0, NMAX - 1
        local_s = local_s + (-1.)**k / (2*k + 1)
    end do
    !$omp end do

    !$omp critical
    s = s + local_s
    !$omp end critical

    !$omp end parallel

    pi = 4 * s
    t2 = omp_get_wtime()

    write (*, *) "OPENMP CRITICAL"
    write (*, *) "PI = ", pi
    write (*, '(A, F10.5)') "TIME = ", t2 - t1
    write (*, *)

    write (*, *) "THREADS = ", omp_get_max_threads()

end program main