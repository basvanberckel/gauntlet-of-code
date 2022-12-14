module m
    implicit none
contains
    function check(grid, x, y) result(result)
        character, dimension(99,99) :: grid
        integer :: x, y, i
        integer :: result, subresult
        result = 1
        subresult = 0
        do i = 1, x -1
            subresult = subresult + 1
            ! print *, i, grid(x, y), grid(x-i, y)
            if (grid(x, y) <= grid(x-i, y)) then
                exit
            end if
        end do
        result = result * subresult
        ! print*, x, y, result, subresult
        subresult = 0
        do i = x+1, 99
            subresult = subresult + 1
            if (grid(x, y) <= grid(i, y)) then
                exit
            end if
        end do
        result = result * subresult
        ! print*, x, y, result, subresult
        subresult = 0
        do i = 1, y-1
            subresult = subresult + 1
            if (grid(x, y) <= grid(x, y-i)) then
                exit
            end if
        end do
        result = result * subresult
        ! print*, x, y, result, subresult
        subresult = 0
        do i = y+1, 99
            subresult = subresult + 1
            if (grid(x, y) <= grid(x, i)) then
                exit
            end if
        end do
        result = result * subresult
        ! print*, x, y, result, subresult
    end function check
end module

program p
    use m
    implicit none
    character, dimension(99,99) :: grid
    character, dimension(99) :: line
    integer :: i, j, solution = 0, inputfileno, eof = 0
    character(len=10) :: expected
    character(len=1), parameter :: filename = "2"
    integer :: result
    
    open(newunit=inputfileno, file="cases/input/"//filename, status="old", action="read")

    do i = 1, 99
        read(inputfileno, '(*(A))') grid(i, :)
    end do

    do i = 1, 99
        do j = 1, 99
            result = check(grid, i, j)
            print*, i, j, grid(i, j), result
            if (result > solution) then
                solution = result
            end if
        end do
    end do

    ! print *, check(grid, 4, 3)

    print*, solution
end program p