FROM ruby:3.0.3 as development

ENV APP_PATH=/usr/src
WORKDIR $APP_PATH

COPY Gemfile* $APP_PATH/
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

# 

FROM development as production

ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true
ENV SECRET_KEY_BASE=67186287few61287

COPY . .

RUN DATABASE_URL=postgresql://user:password@db:5432/development rails assets:precompile

CMD puma -t 3:5 -w 2 -b tcp://0.0.0.0:3000