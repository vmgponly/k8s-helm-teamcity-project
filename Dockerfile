# ================================
# deps : gemビルド用イメージ
# ================================
FROM ruby:2.6.5-alpine AS deps

RUN apk add -U --no-cache \
    build-base \
    tzdata
RUN gem install bundler -v '~> 2.1.4'

WORKDIR /app
COPY .ruby-version Gemfile Gemfile.lock /app/
COPY vendor/cache /app/vendor/cache
RUN bundle install --local \
    && rm -rf vendor/bundle/ruby/*/cache vendor/cache/*.gem

# ================================
# base : appコピー用イメージ
# ================================
FROM alpine AS app

COPY . /app
RUN rm -rf /app/vendor/cache


# ================================
# 実行用イメージ
# ================================
FROM ruby:2.6.5-alpine as app-base

RUN apk add -U --no-cache \
    bash \
    tzdata \
    nodejs
RUN gem install bundler -v '~> 2.1.4'

WORKDIR /app

COPY --from=deps /usr/local/bundle /usr/local/bundle
COPY --from=app /app /app

FROM app-base as app-run-server

EXPOSE 3000
CMD ["rails", "s", "-b", "0.0.0.0"]

FROM app-base as batch-run-server

CMD ["sh", "/app/scripts/launch.sh"]
