FROM ruby:2.7.3-alpine

RUN apk -U add build-base postgresql-dev tzdata nodejs
ENV APP_DIR=/api
WORKDIR ${APP_DIR}

COPY Gemfile ${APP_DIR}/Gemfile
COPY Gemfile.lock ${APP_DIR}/Gemfile.lock

RUN bundle install

COPY . ${APP_DIR}

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 1234
EXPOSE 3000
EXPOSE 26162

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]