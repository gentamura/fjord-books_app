# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :bookable, polymorphic: true
      t.references :reportable, polymorphic: true
      t.references :userable, polymorphic: true

      t.timestamps
    end
  end
end
