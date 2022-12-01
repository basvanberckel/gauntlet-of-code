FROM rust

WORKDIR /app

COPY cases cases

COPY solution.rs solution.rs

CMD rustc -o solution solution.rs && ./solution