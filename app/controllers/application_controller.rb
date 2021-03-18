# frozen_string_literal: true

require 'json_web_token'

class ApplicationController < ActionController::API
  include ExceptionHandler
  include Secured
  include Pundit

  def current_user
    raise NotImplementedError
  end
end
