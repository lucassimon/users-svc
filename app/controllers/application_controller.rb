# frozen_string_literal: true

require 'json_web_token'

class ApplicationController < ActionController::API
  include ExceptionHandler
  include Secured
  include Pundit

  attr_reader :current_user
end
