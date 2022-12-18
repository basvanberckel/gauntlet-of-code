
run: build
	docker run --rm aoc-ijs

it: build
	docker run -it --entrypoint ijconsole aoc-ijs solution.ijs
	
build:
	docker build -qt aoc-ijs .
