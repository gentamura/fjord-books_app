# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :bookable, polymorphic: true, optional: true
  belongs_to :reportable, polymorphic: true, optional: true
  belongs_to :userable, polymorphic: true

  validates :content, presence: true
end
