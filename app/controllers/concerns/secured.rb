# frozen_string_literal: true

module Secured
  extend ActiveSupport::Concern

  private

  def authenticate_request!
    auth_token
  end

  def http_token
    request.headers['Authorization'].split.last if request.headers['Authorization'].present?
  end

  def auth_token
    JsonWebToken.verify(http_token)
  end
end
