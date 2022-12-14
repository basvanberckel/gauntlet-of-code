module m
    implicit none
contains
    function check(grid, x, y) result(result)
        character, dimension(99,99) :: grid
        integer :: x, y, i
        logical :: result
        result = .TRUE.
        ! print*, x, y
        do i = 1, x -1
            if (grid(x, y) <= grid(i, y)) then
                result = .FALSE.
            end if
        end do
        if (result) then 
            return 
        end if
        result = .TRUE.
        ! print*, x, y
        do i = x+1, 99
            if (grid(x, y) <= grid(i, y)) then
                result = .FALSE.
            end if
        end do
        if (result) then 
            return 
        end if
        result = .TRUE.
        ! print*, x, y
        do i = 1, y-1
            if (grid(x, y) <= grid(x, i)) then
                result = .FALSE.
            end if
        end do
        if (result) then 
            return 
        end if
        result = .TRUE.
        ! print*, x, y
        do i = y+1, 99
            if (grid(x, y) <= grid(x, i)) then
                result = .FALSE.
            end if
        end do
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
    logical :: result
    
    open(newunit=inputfileno, file="cases/input/"//filename, status="old", action="read")

    do i = 1, 99
        read(inputfileno, '(*(A))') grid(i, :)
    end do

    do i = 1, 99
        do j = 1, 99
            result = check(grid, i, j)
            ! print*, i, j, grid(i, j), result
            if (result) then
                solution = solution + 1
            end if
        end do
    end do

    print*, solution
end program p