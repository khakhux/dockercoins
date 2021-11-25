FROM python:alpine

RUN pip install redis

FROM scratch
COPY --from=0 / /
