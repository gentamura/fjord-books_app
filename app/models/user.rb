# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def self.find_for_github_oauth(auth)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    unless user
      params = {
        name: auth.extra.raw_info.name,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      }

      user = User.create(**params)
    end

    user
  end

  # 通常サインアップ時のuid用
  def self.create_unique_string
    SecureRandom.uuid
  end
end
