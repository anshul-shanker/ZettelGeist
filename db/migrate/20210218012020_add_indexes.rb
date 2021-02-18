class AddIndexes < ActiveRecord::Migration[6.1]
  def change
    add_index :notes, :tags
    add_index :notes, :mentions
    add_index :notes, :body
    add_index :notes, :title
  end
end
