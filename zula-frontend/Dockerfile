FROM node:latest

WORKDIR /app

COPY package*.json /app/

RUN npm ci && npm install -g serve

COPY ./public/* public/
COPY tsconfig.json tsconfig.json
COPY ./src/* src/
COPY entrypoint.sh entrypoint.sh

RUN chmod +x entrypoint.sh
RUN ./entrypoint.sh

ENTRYPOINT serve -s build