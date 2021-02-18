class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string     :title 
      t.string     :tags, array: true, default: []
      t.string     :mentions, array: true, default: []
      t.string     :body
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
