FROM gcc

RUN apt-get update -y && apt-get install nasm gdb -y

WORKDIR /app

COPY cases cases

COPY solution.asm solution.asm

RUN nasm -felf64 -g -F dwarf solution.asm && ld -o solution solution.o

CMD ./solution