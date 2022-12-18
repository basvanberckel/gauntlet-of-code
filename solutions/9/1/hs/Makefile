
run: build
	docker run --rm aoc-hs

dbg: build
	docker run -it --rm aoc-hs ghci solution.hs
	
build:
	docker build -qt aoc-hs .
