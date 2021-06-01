# frozen_string_literal: true

require 'rails_helper'
require 'pundit/rspec'

RSpec.describe BlogPolicy, type: :policy do
  subject(:policy) { described_class }

  let(:blog) { create(:blog) }

  context 'when a visitor tries to access' do
    let(:user) { {} }

    permissions :index?, :show?, :create?, :new?, :update?, :edit?, :destroy? do
      it 'denies all' do
        expect(policy).not_to permit(user, blog)
      end
    end
  end

  context 'when the author tries to access' do
    let(:user) { { id: blog.author_id } }

    permissions :show?, :create?, :new?, :update?, :edit?, :destroy? do
      it 'denies all' do
        expect(policy).to permit(user, blog)
      end
    end
  end
end
