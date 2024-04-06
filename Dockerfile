FROM ruby:3.2 as base

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

WORKDIR /app

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

ADD . /app

ARG DEFAULT_PORT 3000

EXPOSE ${DEFAULT_PORT}

CMD ["rails", "server", "-b", "0.0.0.0"]
