class AddMoreFieldsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :url_original, :string
  end
end
