# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  has_many :following_relationships, class_name: 'FollowRelationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy,
                                  inverse_of: :follower
  has_many :followings, through: :following_relationships

  has_many :follower_relationships, class_name: 'FollowRelationship',
                                   foreign_key: 'following_id',
                                   dependent: :destroy,
                                   inverse_of: :following
  has_many :followers, through: :follower_relationships

  def follow(other_user)
    following_relationships.create(following_id: other_user.id)
  end

  def unfollow(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
