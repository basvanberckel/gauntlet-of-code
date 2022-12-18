FROM zenika/kotlin

WORKDIR /app

COPY cases cases

COPY solution.kt solution.kt

CMD kotlinc solution.kt -include-runtime -d solution.jar && java -jar solution.jar