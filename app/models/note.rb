class Note < ApplicationRecord
  belongs_to :user
  # binding.pry

  scope :notes_by_user, ->(user_id) { where(user_id: user_id) }
  scope :notes_not_by_user, ->(user_id) { where.not(user_id: user_id) }

  include PgSearch
  pg_search_scope :pg_search, against: [:title, :body, :tags, :mentions], using: { tsearch: { prefix: true, tsvector_column: "tsv" } }
end
