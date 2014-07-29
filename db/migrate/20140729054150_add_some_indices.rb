class AddSomeIndices < ActiveRecord::Migration
  def change
     add_index :photos, :album_id
     add_index :photos, :taken_at
     add_index :photos, :visible

     add_index :albums, :collection_id

     add_index :events, :start_date

     add_index :posts, :album_id
     add_index :posts, :intern
  end
end
