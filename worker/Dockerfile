FROM python:alpine

RUN pip install redis
RUN pip install requests

FROM scratch
COPY --from=0 / /
