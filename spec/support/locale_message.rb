# frozen_string_literal: true

module LocaleMessageMethods
  def locale_message(key, scope, default: :default)
    I18n.t key, scope: scope, default: default
  end
end

RSpec.configure do |config|
  config.include LocaleMessageMethods
end
