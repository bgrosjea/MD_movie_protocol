program XYZ_stride

    ! Declare variables
    implicit none
    real :: t0, t
    integer :: nstep, natom, start, stride, last, i, iarg, istep
    character(500) :: current_line, XYZ, arg
    ! END declare variables

    ! Read bash arguments
    call readArguments(natom,XYZ,start,stride,last)
    print *, 'XYZ = ', trim(XYZ)
    print *, 'Exporting steps = ', start, stride, last
    ! END read bash arguments

    ! Opening files ! 
    open(101, file = 'XYZ_stride.out')
    open(001, file = XYZ)
    ! END opening files ! 
    
    ! Reading input, writing output ! 
    call cpu_time(t0)
    do istep = 1, last ! browsing MD steps

        do i = 1, natom + 2 ! browsing current MD step
            read(001, '(A)') current_line
            if ((istep >= start) .AND. (istep <= last) .AND. (mod(istep-start,stride) == 0) ) then
                write(101, *) trim(current_line)
            end if
        end do ! END browsing current MD step

        ! Run time info
        if (istep == 1000) then 
            call cpu_time(t)
            print *,'Estimated remaining time = ',nint(dble(last-istep)*(t-t0)/dble(istep)/60.d0),' min' 
        end if      
        if( mod(istep,5000)==0 ) print*,"READING step ",istep," over ",last
        ! END run time info

    end do ! END browsing MD steps
    ! END reading input, writing output ! 

    ! Closing files ! 
    close(001)
    close(101)
    ! END closing files !

    ! subroutines and functions
    contains
        subroutine readArguments(natom,XYZ,start,stride,last)
            integer, intent(out) :: natom, start, stride, last
            character (len=*), intent(out) :: XYZ
            call get_command_argument(1,arg,status=iarg)
            read(arg,*) natom
            call get_command_argument(2,arg,status=iarg)
            read(arg,*) XYZ
            call get_command_argument(3,arg,status=iarg)
            read(arg,*) start
            call get_command_argument(4,arg,status=iarg)
            read(arg,*) stride
            call get_command_argument(5,arg,status=iarg)
            read(arg,*) last
        end subroutine
    ! END subroutines and functions
end program XYZ_stride