# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  Healthcheck.routes(self)

  namespace :v1 do
    resources :blogs
  end
end
