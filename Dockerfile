FROM ruby:2.7.0
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /tkmoto2
WORKDIR /tkmoto2

COPY Gemfile /tkmoto2/Gemfile
COPY Gemfile.lock /tkmoto2/Gemfile.lock

ADD . /tkmoto2

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt-get update \
&& apt-get install -y yarn mc
RUN gem update --system
RUN gem install bundler -v 1.17.1
RUN bundle install
RUN bundle update --bundler

EXPOSE 3000

