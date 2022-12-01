FROM gcc

RUN apt-get update -y && apt-get install gdb -y

WORKDIR /app

COPY cases cases

COPY solution.c solution.c

RUN gcc -g -o solution solution.c 

CMD ./solution