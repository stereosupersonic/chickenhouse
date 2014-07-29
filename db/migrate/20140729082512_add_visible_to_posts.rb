class AddVisibleToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :visible, :boolean, :default => true
    add_column :events, :visible, :boolean, :default => true

    add_index :posts, :visible
    add_index :events, :visible
  end
end
