class Note < ApplicationRecord
  belongs_to :user
  # binding.pry

  scope :notes_by_user, ->(user_id) { where(user_id: user_id) }

  
end
