FROM ruby:2.7.6

RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  && rm -rf /var/lib/apt/lists/*

RUN gem install bundler:2.2.3
RUN gem install nokogiri

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle config set force_ruby_platform true
RUN bundle install

COPY . .