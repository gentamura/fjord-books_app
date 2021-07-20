# frozen_string_literal: true

class User < ApplicationRecord
  ALLOWED_AVATAR_EXTENSIONS = ['image/png', 'image/jpg', 'image/jpeg', 'image/gif'].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  validate :avatar_content_type, if: :avatar_attached?

  def avatar_content_type
    return if avatar.content_type.in?(ALLOWED_AVATAR_EXTENSIONS)

    ext_str = ALLOWED_AVATAR_EXTENSIONS.map { |t| t.sub('image/', '') }.join('、')
    errors.add(User.human_attribute_name(:avatar), "の拡張子が正しくありません。#{ext_str}のいずれかの画像をアップロードしてください。")
  end

  private

  def avatar_attached?
    avatar.attached?
  end
end
