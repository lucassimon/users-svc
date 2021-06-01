# frozen_string_literal: true

# == Schema Information
#
# Table name: blogs
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer          not null
#
# Indexes
#
#  index_blogs_on_author_id  (author_id)
#
FactoryBot.define do
  factory :blog do
    title { Faker::Book.title }
    author_id { Faker::Number.number(digits: 2) }
  end
end
