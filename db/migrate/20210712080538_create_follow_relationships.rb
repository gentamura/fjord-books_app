# frozen_string_literal: true

class CreateFollowRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_relationships do |t|
      t.references :following, null: false, foreign_key: true
      t.references :follower, null: false, foreign_key: true

      t.timestamps
    end

    add_index :follow_relationships, %i[following_id follower_id], unique: true
  end
end
