# frozen_string_literal: true

require 'json_web_token'
require 'profiles/session'

class ApplicationController < ActionController::API
  include ExceptionHandler
  include Secured
  include Pundit

  attr_reader :current_user
end
