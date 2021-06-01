# frozen_string_literal: true

# Handle common CRUD exceptions to send an appropriate message
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end

    rescue_from Pundit::NotAuthorizedError do |e|
      render json: { message: e.message }, status: :forbidden
    end

    rescue_from JWT::VerificationError, JWT::DecodeError do
      render json: { message: 'Missing or invalid token' }, status: :unauthorized
    end
  end
end
