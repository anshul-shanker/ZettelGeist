json.extract! note, :id, :title, :body, :user_id, :tags, :mentions, :created_at, :updated_at
json.url note_url(note, format: :json)
