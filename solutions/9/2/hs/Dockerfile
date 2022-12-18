FROM haskell

WORKDIR /app

COPY cases cases

COPY solution.hs solution.hs

CMD ghc -o solution solution.hs && ./solution