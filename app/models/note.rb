class Note < ApplicationRecord
  include PgSearch

  # pg_search_scope :search_for, against: %i(title tags mentions body)

  # pg_search_scope :search_content_for, against: :body, using: { tsearch: { any_word: true } }

  # pg_search_scope :search_full_text, against: {
  #   title:   'A',
  #   tags: 'B',
  #   mentions: 'C',
  #   body: 'D'
  # } 
end
