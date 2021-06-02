# Minato Rails

Minato Rails is the base Rails application  used at [Ferreri](https://ferreri.co) to create API services.

## Gemfile

The lastest and greatest gems used are located at the [Gemfile](Gemfile).

It includes application gems like:

- [Config](https://github.com/rubyconfig/config) for multi stage configurations
- [Postgres](https://github.com/ged/ruby-pg) for access to the Postgres database
- [Pundit](https://github.com/varvet/pundit) for access control
- [Rack CORS](https://github.com/cyu/rack-cors) for control Cross-Site Resource Sharing
- [Rails::Healthcheck](https://github.com/linqueta/rails-healthcheck) for check the application health
- [Rswag](https://github.com/rswag/rswag) for generate API specifications from RSpec examples

And develompent gems like:

- [Annotate](https://github.com/ctran/annotate_models) for summarizing the current schema
- [debase](https://github.com/ruby-debug/debase) for debug purpose
- [pry](https://github.com/pry/pry) for better dev console
- [rubocop](https://github.com/rubocop-hq/rubocop) for code analyzing and formatting
- [ruby-debug-ide](https://github.com/ruby-debug/ruby-debug-ide) for integrate to IDE debugger

And testing gems like:
- [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner) for cleaning database strategies
- [faker](https://github.com/faker-ruby/faker) for generating fake data
- [Rspec](https://github.com/rspec/rspec) for unit testing
- [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) for common RSpec matchers
- [simplecov](https://github.com/simplecov-ruby/simplecov) for code coverage

## Configurations

The app configurations are located at

```
config/settings.yml
config/settings/#{environment}.yml

config/settings.local.yml
config/settings/#{environment}.local.yml
```
Settings defined in files that are lower in the list override settings higher.

For more information, please see the [Config](https://github.com/rubyconfig/config) documentation.

> The database connection is pre-configured. You just need to change the development and test database names, located at config/database.yml file.

## Local development environment

We use docker and docker-compose for development environment.

### Building and starting the container

Under the app folder execute the following commands:
```bash
$ docker-compose up --build
```

### Starting the Rails server

#### On vscode

Start debugging using the **_Listen for rdebug_** settings or press F5.