# frozen_string_literal: true

require 'json_web_token'

class ApplicationController < ActionController::API
  include ExceptionHandler
  include Secured
  include Pundit

  def current_user
    identity_id = auth_token.first['session']['identity']['id']
    @current_user ||= User.find_by(identity_id: identity_id)
  end
end
