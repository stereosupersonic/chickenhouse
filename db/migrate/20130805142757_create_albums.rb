class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :flickr_id
      t.text :flickr_description
      t.string :flickr_title
      t.string :iconsmall
      t.string :iconlarge
      t.integer :collection_id

      t.timestamps
    end
  end
end
