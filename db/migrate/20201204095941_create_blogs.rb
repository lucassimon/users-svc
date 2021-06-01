# frozen_string_literal: true

# Create the blogs table
class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :title, null: false
      t.integer :author_id, null: false, index: true

      t.timestamps
    end
  end
end
