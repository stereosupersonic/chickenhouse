require 'net/https'
require 'uri'
require 'flickr_helper'
include FlickrHelper

class FlickrUpdater
  def create_article(post)
    post = Post.new post.except(*%w(postable tweet_id out_of_date postable_type postable_id tags))
    post.content = post.html_content
    post.intern = false
    post.user = User.first
    post.save!
  end

  def create_event(post)
    event = Event.new post.slice(*%w(content title id created_at updated_at))
    event.attributes = post['postable'].slice(*%w(start_date location end_date all_day))
    event.location = post['postable']['place'] # if   event.location.blank?
    event.content = event.html_content
    event.user = User.first
    event.save!
  end

  def build_photo(album, photo_hash)
    if photo_hash['media'] == 'photo'
      album.photos.create do |photo|
        photo.flickr_id = photo_hash['id']
        photo.flickr_description = photo_hash['title']
        photo.flickr_title = photo_hash['title'].presence || photo_hash['id']
        photo.url_icon     = photo_hash['url_sq']
        photo.url_big      = photo_hash['url_l']
        photo.url_original = photo_hash['url_o']
        photo.url_small    = photo_hash['url_s']
        photo.taken_at     = photo_hash['datetaken'].to_datetime
        photo.created_at   = photo_hash['datetaken'].to_datetime
        photo.updated_at   = photo_hash['datetaken'].to_datetime
        if photo_hash['isprimary'].to_i == 1
          album.iconsmall   =  photo.url_icon
          album.iconlarge   =  photo.url_big
          album.main_photo  =  photo
        end
        photo
      end
    end
  end

  def build_album(collection, album_hash)
    collection.albums.create do |album|
      puts "import Album #{album_hash['title']}"
      album.flickr_id             = album_hash['id']
      album.flickr_title          = album_hash['title']
      album.flickr_description    = album_hash['description']
      flickr_access.photosets.getPhotos(
        photoset_id: album.flickr_id,
        extras: 'license, date_upload, date_taken, owner_name, icon_server, original_format, last_update, geo, tags, machine_tags, o_dims, views, media, path_alias, url_sq, url_c, url_l, url_s, url_m, url_o').to_hash['photo'].to_a.each do |photo|
        build_photo album, photo
      end
    end
  end

  def build_or_update_album(collection, album_hash)
    flickr_id = album_hash['id']
    unless collection.albums.find_by_flickr_id(flickr_id)
      build_album(collection, album_hash)
    end
  end

  def update!
    flickr_access.collections.getTree.to_hash['collection'].find {|c|c.title == 'henaheisl'}.to_hash['collection'].to_a.each do |collection_hash|
      flickr_id = collection_hash['id']
    Collection.find_by_flickr_id(flickr_id) do |col|
      puts "***** Update collection #{col['title']}"
      collection_hash['set'].each do |album_hash|
        build_or_update_album(col, album_hash)
      end
    end
  end

    # update created_at
    Album.all.each do |album|
      album.created_at = album.photos.order('created_at').last.created_at
      album.save!
    end

    Album.find_each do |album|
      if album.post.nil?
        post = album.create_post
        puts "created: #{post.title}"
      end
    end
   end
end
