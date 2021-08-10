class RemoveTagsFromNotes < ActiveRecord::Migration[6.1]
  def change
    remove_column :notes, :tags, :string
  end
end
