class AddSmallToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :url_small, :string
  end
end
