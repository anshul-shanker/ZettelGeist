class CreateNotesTags < ActiveRecord::Migration[6.1]
  def change
    create_table :notes_tags, id: false do |t|
      t.references :note
      t.references :tag
    end
  end
end
