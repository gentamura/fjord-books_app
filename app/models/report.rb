class Report < ApplicationRecord
  belongs_to :userable, polymorphic: true
end
