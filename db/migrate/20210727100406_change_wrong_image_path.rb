class ChangeWrongImagePath < ActiveRecord::Migration[5.2]
  def up
    Post.where("content like '%henaheisl.com/bilder%'").find_each do |post|
      post.content = post.content.gsub("http://henaheisl.com/bilder", "/bilder")
      post.save!
    end
  end
end
