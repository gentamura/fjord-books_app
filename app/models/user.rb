# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  validate :avatar_content_type, if: :avatar_attached?

  def avatar_content_type
    extension = ['image/png', 'image/jpg', 'image/jpeg', 'image/gif']
    return if avatar.content_type.in?(extension)

    ext_str = extension.map { |t| t.sub('image/', '') }.join('、')
    errors.add(User.human_attribute_name(:avatar), "の拡張子が正しくありません。#{ext_str}のいずれかの画像をアップロードしてください。")
  end

  private

  def avatar_attached?
    avatar.attached?
  end
end
