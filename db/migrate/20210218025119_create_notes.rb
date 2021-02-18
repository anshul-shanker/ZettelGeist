class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string     :title
      t.text       :body
      t.references :user, null: false, index: true, foreign_key: true
      t.string     :tags, array: true, default: []
      t.string     :mentions, array: true, default: []

      t.timestamps
    end

    add_index :notes, :tags
    add_index :notes, :mentions
    add_index :notes, :body
    add_index :notes, :title
  end
end
