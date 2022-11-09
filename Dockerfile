# Lobsters
#
# VERSION latest
ARG BASE_IMAGE=ruby:2.7-alpine
FROM ${BASE_IMAGE}

# Create lobsters user and group.
RUN set -xe; \
    addgroup -S lobsters; \
    adduser -S -h /lobsters -s /bin/sh -G lobsters lobsters;

# Install needed runtime dependencies.
RUN set -xe; \
    chown -R lobsters:lobsters /lobsters; \
    apk add --no-cache --update --virtual .runtime-deps \
    mariadb-connector-c \
    bash \
    nodejs \
    npm \
    sqlite-libs \
    tzdata;

# Change shell to bash
SHELL ["/bin/bash", "-c"]

# Install needed development dependencies. If this is a developer_build we don't remove
# the build-deps after doing a bundle install.
# Copy Gemfile to container.
COPY --chown=lobsters:lobsters ./lobsters/Gemfile ./lobsters/Gemfile.lock /lobsters/
ARG DEVELOPER_BUILD=false
RUN set -xe; \
    apk add --no-cache --virtual .build-deps \
    build-base \
    curl \
    gcc \
    git \
    gnupg \
    linux-headers \
    mariadb-connector-c-dev \
    mariadb-dev \
    sqlite-dev; \
    export PATH=/lobsters/.gem/ruby/2.7.0/bin:$PATH; \
    export SUPATH=$PATH; \
    export GEM_HOME="/lobsters/.gem"; \
    export GEM_PATH="/lobsters/.gem"; \
    export BUNDLE_PATH="/lobsters/.bundle"; \
    cd /lobsters; \
    su lobsters -c "gem install bundler --user-install"; \
    su lobsters -c "gem update bundler"; \
    su lobsters -c "bundle config set no-cache 'true'"; \
    su lobsters -c "bundle install"; \
    if [ "${DEVELOPER_BUILD,,}" != "true" ]; \
    then \
        apk del .build-deps; \
    fi; \
    rm -rf /lobsters/.bundle/cache/; \
    rm -rf /lobsters/.bundle/ruby/2.7.0/cache/; \
    rm -rf /lobsters/.gem/cache/; \
    rm -rf /lobsters/.gem/ruby/2.7.0/cache/; \
    cp /lobsters/Gemfile /lobsters/Gemfile.bak; \
    cp /lobsters/Gemfile.lock /lobsters/Gemfile.lock.bak;
