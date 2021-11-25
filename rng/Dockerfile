FROM python:alpine

RUN pip install flask

FROM scratch
COPY --from=0 / /
