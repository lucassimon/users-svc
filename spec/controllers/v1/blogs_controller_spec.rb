# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::BlogsController, type: :controller do
  describe 'routes' do
    it { should route(:get, '/v1/blogs').to(action: :index) }
    it { should route(:post, '/v1/blogs').to(action: :create) }
    it { should route(:get, '/v1/blogs/1').to(action: :show, id: 1) }
    it { should route(:put, '/v1/blogs/1').to(action: :update, id: 1) }
    it { should route(:delete, '/v1/blogs/1').to(action: :destroy, id: 1) }
  end

  describe 'exception handlers' do
    it { should rescue_from(ActiveRecord::RecordNotFound) }
    it { should rescue_from(ActiveRecord::RecordInvalid) }
    it { should rescue_from(Pundit::NotAuthorizedError) }
    it { should rescue_from(JWT::VerificationError) }
    it { should rescue_from(JWT::DecodeError) }
  end

  describe 'callbacks' do
    it { should use_before_action(:set_blog) }
  end
end
