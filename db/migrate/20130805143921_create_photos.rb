class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :flickr_id
      t.text :flickr_description
      t.string :flickr_title
      t.string :url_icon
      t.string :url_big
      t.integer :album_id

      t.timestamps
    end
  end
end
