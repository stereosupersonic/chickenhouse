class AddVisibleAtToFotos < ActiveRecord::Migration
  def change
    add_column :photos, :visible, :boolean, :default => true
  end
end
