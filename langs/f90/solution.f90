module m
    implicit none
contains
    subroutine solve(list, solution)
        integer, dimension(1:) :: list
        integer :: solution, i
        do i = lbound(list, 1) + 1, ubound(list, 1)
            if (list(i) > list(i-1)) then
                solution = solution + 1
            end if
        end do
    end subroutine solve
end module

program p
    use m
    implicit none
    integer, allocatable, dimension(:) :: list
    integer :: i, solution, inputfileno, outputfileno, lines = 0, eof = 0
    logical :: outputfileexists
    character(len=10) :: expected, tmp
    character(len=1), parameter :: filename = "1"
    
    open(newunit=inputfileno, file="cases/input/"//filename, status="old", action="read")

    do while (eof == 0)
        lines = lines + 1
        read(inputfileno,*,iostat=eof) tmp
    end do
    lines = lines - 1

    allocate(list(lines))
    rewind(inputfileno)

    do i = 1, lines
        read(inputfileno, "(I3)") list(i)
    end do

    call solve(list, solution)

    print*, solution

    deallocate(list)
end program p