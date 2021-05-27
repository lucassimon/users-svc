# frozen_string_literal: true

module Secured
  extend ActiveSupport::Concern

  private

  def authenticate_request!
    @current_user ||= auth_token['session']['user'].symbolize_keys if auth_token['session']
  end

  def http_token
    return nil if request.headers['Authorization'].blank?

    request.headers['Authorization'].split.last
  end

  def auth_token
    @auth_token ||= JsonWebToken.verify(http_token)
  end
end
