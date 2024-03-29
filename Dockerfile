# Dockerfile

FROM ruby:2.7.1

WORKDIR /code
COPY . /code
RUN bundle install

EXPOSE 8090

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "8090"]
