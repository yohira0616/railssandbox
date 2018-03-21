FROM ruby:2.5

ENV MY_APP_DIR /app

RUN mkdir $MY_APP_DIR

WORKDIR $MY_APP_DIR

COPY Gemfile $MY_APP_DIR
COPY Gemfile.lock $MY_APP_DIR
RUN ["bundle","install","-j4"]
