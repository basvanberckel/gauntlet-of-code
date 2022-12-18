
run: build
	docker run aoc-hs

dbg: build
	docker run -it aoc-hs ghci solution.hs
	
build:
	docker build -qt aoc-hs .
