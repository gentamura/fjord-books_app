# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :userable, polymorphic: true
  has_many :comments, as: :reportable, dependent: :destroy
end
