# frozen_string_literal: true

Faker::Config.locale = Settings.i18n.default_locale

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
