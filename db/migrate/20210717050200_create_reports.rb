# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :userable, polymorphic: true

      t.timestamps
    end
  end
end
