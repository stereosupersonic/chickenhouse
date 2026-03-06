class RemoveUnusedPostsColumns < ActiveRecord::Migration[8.1]
  def change
    remove_index :posts, :album_id
    remove_index :posts, :title

    remove_column :posts, :album_id, :integer
    remove_column :posts, :attachment_content_type, :string, limit: 255
    remove_column :posts, :attachment_file_name, :string, limit: 255
    remove_column :posts, :attachment_file_size, :integer
    remove_column :posts, :attachment_updated_at, :datetime
    remove_column :posts, :media_type, :string, limit: 255
    remove_column :posts, :out_of_date, :datetime
    remove_column :posts, :twitter_export, :boolean, default: true
  end
end
