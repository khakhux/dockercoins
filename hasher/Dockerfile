FROM ruby:alpine

RUN apk add build-base
RUN gem install sinatra
RUN gem install thin

FROM scratch
COPY --from=0 / /
