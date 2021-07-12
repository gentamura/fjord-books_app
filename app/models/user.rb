# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :active_relationships, class_name: 'FollowRelationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy,
                                  inverse_of: :follow_relationships
  has_many :followings, through: :active_relationships

  has_many :passive_relationships, class_name: 'FollowRelationship',
                                   foreign_key: 'following_id',
                                   dependent: :destroy,
                                   inverse_of: :follow_relationships
  has_many :followers, through: :passive_relationships
end
