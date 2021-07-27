class AddMainPhotoToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :main_photo_id, :integer
    add_column :posts, :album_id, :integer
  end
end
