class AddFriendlyIdFields < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string, unique: true
    add_column :users, :slug, :string, unique: true
    add_column :events, :slug, :string, unique: true
    add_column :albums, :slug, :string, unique: true
    add_column :collections, :slug, :string, unique: true
    add_column :photos, :slug, :string, unique: true
  end
end
