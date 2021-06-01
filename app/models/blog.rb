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
class Blog < ApplicationRecord
  validates :title, :author_id, presence: true
end
