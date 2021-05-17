# frozen_string_literal: true

I18n.load_path += Dir[Rails.root.join('config/locales/*.{rb,yml}')]
I18n.available_locales = Settings.i18n.available_locales
I18n.default_locale = Settings.i18n.default_locale
