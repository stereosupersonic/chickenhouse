require "net/https"
require "uri"
require "flickr_helper"
include FlickrHelper

namespace :import do
  # {"post"=>{"tweet_id"=>nil, "postable_type"=>"Article", "attachment_file_name"=>"Ergebnisse_2013.pdf",
  #    "postable"=>{"created_at"=>"2013-12-28T16:16:32+01:00", "updated_at"=>"2013-12-28T16:16:32+01:00", "id"=>62, "sticky"=>nil},
  #    "media_type"=>"", "created_at"=>"2013-12-28T16:16:32+01:00", "attachment_file_size"=>66146, "attachment_content_type"=>"application/pdf", "twitter_export"=>true, "title"=>"Ergebnisse der 25. Clubmeisterschaft", "postable_id"=>62, "content_type"=>"article", "updated_at"=>"2013-12-28T16:17:49+01:00",
  #    "tags"=>"",
  #    "id"=>132, "user_id"=>2, "media"=>nil, "content"=>"!http://farm8.staticflickr.com/7415/11602969364_171bfefc90.jpg!\r\nDer FC Bayern Fanclub wurde 7.\r\n\r\nDer Sieger der 25. Wartenberger Clubmeisterschaft ist der Fantasy-Club.\r\n\r\nDie Platzierungen:\r\n\r\n|_.  |_.  |\r\n| 1. | Fantasy  |\r\n| 2. | Cosmos |\r\n| 3. | Ski-Club |\r\n| 4. | Reif United |\r\n| 5. | St Ulrich Schützen|\r\n| 6. | Löwen Fanclub  |\r\n| 7. | Bayern FanclubReif-United |\r\n| 8. | Cluberer |\r\n\r\nBilder gibts \"hier\":http://www.flickr.com/photos/sereosonic70/sets/72157639109599746/",
  #    "out_of_date"=>"2014-01-18T16:17:49+01:00", "intern"=>nil, "attachment_updated_at"=>"2013-12-28T16:16:32+01:00"}}
  def create_article(post)
    post = Post.new post.except( *['postable','tweet_id','out_of_date','postable_type', 'postable_id', 'tags'])
    post.content = post.html_content
    post.intern = false
    post.user  = User.first
    post.save!
  end

  #{"post"=>{"tweet_id"=>nil, "postable_type"=>"Event", "attachment_file_name"=>nil,
  #          "postable"=>{"start_date"=>"2014-02-22T20:00:00+01:00", "location"=>"", "created_at"=>"2014-02-16T19:25:32+01:00", "updated_at"=>"2014-02-17T08:24:10+01:00", "id"=>72, "google_feed"=>"http://www.google.com/calendar/feeds/info%40henaheisl.de/events/ilf02l0a40e3d5r7dhmdn97hvs", "place"=>"beim Äwal, Rockelfing", "end_date"=>"2014-02-22T23:23:00+01:00", "all_day"=>false},
  #          "media_type"=>"", "created_at"=>"2014-02-16T19:25:35+01:00", "attachment_file_size"=>nil, "attachment_content_type"=>nil, "twitter_export"=>true, "title"=>"Versammlung", "postable_id"=>72, "content_type"=>"article", "updated_at"=>"2014-02-16T19:25:35+01:00", "tags"=>"", "id"=>134, "user_id"=>2, "media"=>nil,
  #          "content"=>"Versammlung im Gasthaus Bachmaier. Beginn ist um 20 Uhr",
  #  "out_of_date"=>"2014-02-22T20:00:00+01:00", "intern"=>nil, "attachment_updated_at"=>nil}}

  def create_event(post)
    event = Event.new post.slice( *['content','title', 'id', 'created_at', 'updated_at'])
    event.attributes = post['postable'].slice( *['start_date','location', 'end_date', 'all_day'])
    event.location = post['postable']['place']# if   event.location.blank?
    event.content = event.html_content
    event.user  = User.first
    event.save!
  end

  def build_photo(album,photo_hash)
    puts photo_hash.inspect
    if photo_hash["media"] == "photo"
      album.photos.build do | photo |
        #{ "id"=>"4409987415",
        #  "secret"=>"f387431a19",
        #  "server"=>"4037",
        #  "farm"=>5,
        #  "title"=>"Bettelhochzeit 2010 - 060",
        #  "isprimary"=>"0"}


        #{"id"=>"5939153627",
        #"secret"=>"ff8d1e8b5b",
        #"server"=>"6149",
        #"farm"=>7,
        #"title"=>"Original_0046",
        # "isprimary"=>"0",
        # "license"=>"0",
        # "dateupload"=>"1310721177",
        # "datetaken"=>"2010-01-22 12:50:06",
        # "datetakengranularity"=>"0",
        # "ownername"=>"henaheisl1991",
        # "iconserver"=>"1101",
        # "iconfarm"=>2,
        # "originalsecret"=>"f24ecf9885",
        # "originalformat"=>"jpg",
        # "lastupdate"=>"1310721468",
        # "latitude"=>0,
        # "longitude"=>0,
        # "accuracy"=>0,
        # "context"=>0,
        # "tags"=>"",
        # "machine_tags"=>"",
        # "o_width"=>"3488",
        # "o_height"=>"2368",
        # "views"=>"3",
        # "media"=>"photo",
        # "media_status"=>"ready",
        # "pathalias"=>"sereosonic70",
        # "url_sq"=>"http://farm7.staticflickr.com/6149/5939153627_ff8d1e8b5b_s.jpg",
        # "height_sq"=>75,
        # "width_sq"=>75,
        # "url_t"=>"http://farm7.staticflickr.com/6149/5939153627_ff8d1e8b5b_t.jpg",
        # "height_t"=>"68",
        # "width_t"=>"100",
        # "url_s"=>"http://farm7.staticflickr.com/6149/5939153627_ff8d1e8b5b_m.jpg",
        # "height_s"=>"163",
        # "width_s"=>"240",
        # "url_m"=>"http://farm7.staticflickr.com/6149/5939153627_ff8d1e8b5b.jpg",
        # "height_m"=>"339",
        # "width_m"=>"500",
        # "url_o"=>"http://farm7.staticflickr.com/6149/5939153627_f24ecf9885_o.jpg",
        # "height_o"=>"2368",
        # "width_o"=>"3488"}

        photo.flickr_id    = photo_hash['id']
        photo.flickr_description = photo_hash['title']
        photo.flickr_title = photo_hash['title'].presence || photo_hash['id']
        photo.url_icon     = photo_hash['url_sq']
        photo.url_big      = photo_hash['url_l']
        photo.url_original = photo_hash['url_o']
        photo.url_small    = photo_hash['url_s']
        photo.taken_at     = photo_hash['datetaken'].to_datetime
        photo.created_at   = photo_hash['datetaken'].to_datetime
        photo.updated_at   = photo_hash['datetaken'].to_datetime
        if photo_hash["isprimary"].to_i == 1
          album.iconsmall   =  photo.url_icon
          album.iconlarge   =  photo.url_big
          album.main_photo  =  photo
        end
        photo
      end
    end

  end

  def build_album(collection,album_hash)
    #{ "id"=>"72157627074677447",
    #  "title"=>"Freising 1996",
    #  "description"=>""}
    collection.albums.build do |album|
      puts "import Album #{album_hash['title']}"
      album.flickr_id             = album_hash['id']
      album.flickr_title          = album_hash['title']
      album.flickr_description    = album_hash['description']

      # https://www.flickr.com/services/api/flickr.photosets.getPhotos.html

      flickr_access.photosets.getPhotos(
        :photoset_id => album.flickr_id,
        :extras      => 'license, date_upload, date_taken, owner_name, icon_server, original_format, last_update, geo, tags, machine_tags, o_dims, views, media, path_alias, url_sq, url_c, url_l, url_s, url_m, url_o').to_hash['photo'].to_a.each do |photo|
        build_photo album, photo
      end
    end
  end

  def build_collection(collection_hash)

    #{  "id"=>"3851219-72157627074638797",
    #  "title"=>"sportlich",
    #  "description"=>"Unser Sportlichen Aktivitäten",
    #  "iconlarge"=>"http://farm8.staticflickr.com/7142/cols/72157627074638797_13f7be3a93_l.jpg",
    #  "iconsmall"=>"http://farm8.staticflickr.com/7142/cols/72157627074638797_13f7be3a93_s.jpg",
    Collection.new do | col |
      puts "import collection: #{collection_hash['title']}"
      col.flickr_id             = collection_hash['id']
      col.flickr_title          = collection_hash['title']
      col.flickr_description    = collection_hash['description']
      col.iconsmall             = collection_hash['iconsmall']
      col.iconlarge             = collection_hash['iconlarge']

      collection_hash['set'].each { |album_hash |   build_album(col, album_hash) }
    end
  end

  desc "pull down the production data and inster it to db"
  task :blog  => :environment do
    puts "delete all"
    Post.delete_all
    Event.delete_all
    puts "start download"
    http = Net::HTTP.new("henaheisl.com", 80)
    response = http.request(Net::HTTP::Get.new("/posts.json"))
    posts = JSON.parse(response.body)
    pbar = ProgressBar.new("Import",  posts.count)
    events = 0
    articles = 0
    posts.each do |post_hash|
      post = post_hash['post']
      case
      when post['postable_type'] == 'Article'
        create_article(post)
        articles +=1
      when post['postable_type'] == 'Event'
        create_event(post)
        events +=1
      else
        raise  "unknow type #{post['postable_type']}"
      end
      pbar.inc
    end
    puts ""
    puts "import: #{posts.size} events: #{events} articles: #{articles}"
  end

  desc "pull down all collections from flickr db"
  task :flickr  => :environment do
    puts "delete all"
    Photo.delete_all
    Album.delete_all
    Post.destroy_all("album_id is not null")
    Collection.delete_all
    puts "start download"
    # https://www.flickr.com/services/api/flickr.collections.getTree.html
    flickr_access.collections.getTree.to_hash['collection'].find {|c|c.title == 'henaheisl'}.to_hash['collection'].to_a.each do |collection_hash|
      collection = build_collection(collection_hash)
      collection.save!
    end

    #update created_at
    Album.all.each do |album|
      album.created_at = album.photos.order('created_at').last.created_at
      album.save!
    end

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
