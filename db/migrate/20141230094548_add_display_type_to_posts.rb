class AddDisplayTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :display_type, :string, :default => 'textile'
  end
end
