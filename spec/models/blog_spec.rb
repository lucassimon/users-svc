# frozen_string_literal: true

# == Schema Information
#
# Table name: blogs
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
