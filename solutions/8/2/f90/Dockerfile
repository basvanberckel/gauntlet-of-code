FROM nacyot/fortran-gfortran:apt

WORKDIR /app

COPY cases cases

COPY solution.f90 solution.f90

CMD gfortran -o solution solution.f90 && ./solution