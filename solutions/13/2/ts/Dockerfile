FROM node

WORKDIR /app

RUN npm i -g ts-node

COPY cases cases

COPY solution.ts solution.ts

CMD ts-node solution.ts