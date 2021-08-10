class AddTsvectorIndexToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :tsv, :tsvector
    add_index :notes, :tsv, using: 'gin'

    reversible do |dir|
      dir.up do
        execute <<-SQL
          -- https://stackoverflow.com/questions/44090712/how-to-use-tsvector-update-trigger-with-array-types-in-postgresql
          -- The tsvector_update_trigger can't be used for array columns, instead we create a custom function based on the code sample from the postgresql search features page.
          -- Using an array_to_string to convert the array elements to text.


          -- TODO look into ranking
          -- https://www.postgresql.org/docs/9.1/textsearch-controls.html
          
        CREATE FUNCTION update_tsv() RETURNS trigger AS $$
        BEGIN
          new.tsv :=
            to_tsvector('pg_catalog.simple', coalesce(new.title,'')) ||
            to_tsvector('pg_catalog.simple', coalesce(new.body,'')) ||
            to_tsvector('pg_catalog.simple', coalesce(array_to_string(new.mentions, ' '),'')) ||
            to_tsvector('pg_catalog.simple', coalesce(array_to_string(new.tags, ' '),''));
          return new;
        END
        
        $$ LANGUAGE plpgsql;

          CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE ON notes
          FOR EACH ROW EXECUTE PROCEDURE update_tsv();
        SQL

        # Trigger re-index on existing notes
        execute("UPDATE notes SET id = id")
      end
      
      dir.down do 
        execute <<-SQL
          DROP TRIGGER tsvectorupdate
          ON store_items;
          DROP FUNCTION update_tsv();
        SQL
      end
    end
  end
end
