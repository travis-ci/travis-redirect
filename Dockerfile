FROM ruby:2.5.7-slim

LABEL maintainer Travis CI GmbH <support+travis-listener-docker-images@travis-ci.com>

# packages required for bundle install
RUN ( \
   apt-get update ; \
   apt-get install -y --no-install-recommends git make gcc \
   && rm -rf /var/lib/apt/lists/* \
)

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile      /app
COPY Gemfile.lock /app

RUN bundle install --verbose --retry=3 --deployment --without development test

COPY . /app

CMD ["/bin/bash", "-c", "bundle exec rackup config.ru -p ${PORT:-4000} -o 0.0.0.0 -s puma"]