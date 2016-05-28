
require "flickr_updater"


namespace :import do

  desc "pull down all collections from flickr and update"
  task :flickr  => :environment do
    FlickrUpdater.new.update!
  end

  desc "create missing album posts"
  task :create_album_posts  => :environment do
    Album.find_each do |album|
      if album.post.nil?
        post = album.create_post
        puts "created: #{post.title}"
      end
    end

  end

  desc "create all album posts new"
  task :create_all_album_posts  => :environment do
    Post.destroy_all("album_id is not null")
    Album.find_each do |album|
      if album.post.nil?
        post = album.create_post
        puts "created: #{post.title}"
      end
    end

  end
end
