FROM ruby:alpine
RUN gem install sinatra

FROM scratch
COPY --from=0 / /
