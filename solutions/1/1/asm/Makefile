
run: build
	docker run --rm aoc-asm

gdb: build
	docker run --rm -it aoc-asm gdb ./solution
	
build:
	docker build -t aoc-asm .
