class RenameContentInArticles < ActiveRecord::Migration[8.0]
  def change
    rename_column :posts, :content, :old_content
    rename_column :posts, :content_type, :old_content_type
  end
end
