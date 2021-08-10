class Note < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :tags, -> { alphabetical }, class_name: "Note::Tag"

  scope :notes_by_user, ->(user_id) { where(user_id: user_id) }
  scope :notes_not_by_user, ->(user_id) { where.not(user_id: user_id) }

  include PgSearch::Model
  pg_search_scope :pg_search, against: [:title, :body, :mentions], using: { tsearch: { prefix: true, tsvector_column: "tsv" } }
end
