FROM node:4-slim
RUN npm install express
RUN npm install redis

FROM scratch
COPY --from=0 / /
