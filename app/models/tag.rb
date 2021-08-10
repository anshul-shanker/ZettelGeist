class Tag < ApplicationRecord
  scope :alphabetical, -> { order(name: :asc) }

  has_and_belongs_to_many :notes

  validates :name, presence: true
end
