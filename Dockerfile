FROM ruby:2.7.2

ARG INSTALL_DEPENDENCIES
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends ${INSTALL_DEPENDENCIES} \
    build-essential \
    nodejs \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf \
    /var/lib/apt \
    /var/lib/dpkg \
    /var/lib/cache \
    /var/lib/log

RUN mkdir /app
WORKDIR /app
COPY Gemfile* /app/

ARG BUNDLE_INSTALL_ARGS
RUN gem install bundler && bundle install ${BUNDLE_INSTALL_ARGS} \
    && rm -rf /usr/local/bundle/cache/* \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete
COPY . /app/

# CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]