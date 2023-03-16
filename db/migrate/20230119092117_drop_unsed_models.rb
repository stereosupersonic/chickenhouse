class DropUnsedModels < ActiveRecord::Migration[7.0]
  def change

    drop_table :albums
    drop_table :collections
    drop_table :photos
  end
end
