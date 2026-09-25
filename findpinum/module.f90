module module
    implicit none

    integer, parameter :: NMAX = 500000000
    integer, parameter :: NPARTS = 1000
    integer, parameter :: precision = 8
    integer :: i, k

    real(precision) :: pi, s
    real(precision) :: t1, t2
    doubleprecision :: part(NPARTS)

    contains
        pure double precision function series(i)

        integer, intent(in) :: i
        integer :: k, first, last

        first = (i - 1) * (NMAX / NPARTS)
        last  = i * (NMAX / NPARTS) - 1

        series = 0

        do k = first, last
            series = series + (-1)**k / dble(2*k + 1)
        end do
        end function series
end module module