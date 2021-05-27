# frozen_string_literal: true

require 'rails_helper'
require 'pundit/rspec'

RSpec.describe ApplicationPolicy, type: :policy do
  subject(:policy) { described_class }

  let(:user) { {} }
  let(:blog) { create(:blog) }

  permissions :index?, :show?, :create?, :new?, :update?, :edit?, :destroy? do
    it 'denies all' do
      expect(policy).not_to permit(user, blog)
    end
  end

  describe 'scopes' do
    subject(:policy_scope) { described_class::Scope.new(user, scope) }

    before do
      create_list(:blog, 5)
      create_list(:blog, 5, author_id: 1)
    end

    let(:scope) { Blog }

    it 'retrieves all' do
      expect(policy_scope.resolve.size).to eq(10)
    end
  end
end
