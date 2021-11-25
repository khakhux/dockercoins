FROM python:alpine

USER nobody
RUN pip install flask

FROM scratch
COPY --from=0 / /
