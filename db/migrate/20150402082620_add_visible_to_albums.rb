class AddVisibleToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :visible, :boolean, :default => true
    add_index :albums, :visible
  end
end
