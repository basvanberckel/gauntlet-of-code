FROM sbtscala/scala-sbt:eclipse-temurin-19_36_1.8.0_3.2.1

WORKDIR /app

COPY cases cases

COPY solution.sc solution.sc

CMD scalac solution.sc && scala Solution