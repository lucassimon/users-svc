# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'current user' do
    it 'raise NotImplementedError' do
      expect { described_class.new.current_user }.to raise_error(NotImplementedError)
    end
  end
end
