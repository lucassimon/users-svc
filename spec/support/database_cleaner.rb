# frozen_string_literal: true

require 'database_cleaner/active_record'

RSpec.configure do |config|
  # Define database cleaner strategies
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
