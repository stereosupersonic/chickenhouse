class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text     :content
      t.string   :title
      t.boolean  :intern, :default => false
      t.integer  :user_id
      t.text     :media
      t.string   :media_type
      t.string   :content_type
      t.boolean  :twitter_export,                     :default => true
      t.string   :attachment_file_name
      t.string   :attachment_content_type
      t.integer  :attachment_file_size
      t.datetime :attachment_updated_at
      t.timestamps
    end
  end
end
