require "net/https"
require "uri"
namespace :import do
  # {"post"=>{"tweet_id"=>nil, "postable_type"=>"Article", "attachment_file_name"=>"Ergebnisse_2013.pdf",
  #    "postable"=>{"created_at"=>"2013-12-28T16:16:32+01:00", "updated_at"=>"2013-12-28T16:16:32+01:00", "id"=>62, "sticky"=>nil},
  #    "media_type"=>"", "created_at"=>"2013-12-28T16:16:32+01:00", "attachment_file_size"=>66146, "attachment_content_type"=>"application/pdf", "twitter_export"=>true, "title"=>"Ergebnisse der 25. Clubmeisterschaft", "postable_id"=>62, "content_type"=>"article", "updated_at"=>"2013-12-28T16:17:49+01:00", "tags"=>"",
  #    "id"=>132, "user_id"=>2, "media"=>nil, "content"=>"!http://farm8.staticflickr.com/7415/11602969364_171bfefc90.jpg!\r\nDer FC Bayern Fanclub wurde 7.\r\n\r\nDer Sieger der 25. Wartenberger Clubmeisterschaft ist der Fantasy-Club.\r\n\r\nDie Platzierungen:\r\n\r\n|_.  |_.  |\r\n| 1. | Fantasy  |\r\n| 2. | Cosmos |\r\n| 3. | Ski-Club |\r\n| 4. | Reif United |\r\n| 5. | St Ulrich Schützen|\r\n| 6. | Löwen Fanclub  |\r\n| 7. | Bayern FanclubReif-United |\r\n| 8. | Cluberer |\r\n\r\nBilder gibts \"hier\":http://www.flickr.com/photos/sereosonic70/sets/72157639109599746/",
  #    "out_of_date"=>"2014-01-18T16:17:49+01:00", "intern"=>nil, "attachment_updated_at"=>"2013-12-28T16:16:32+01:00"}}
  def create_article(post)
    post = Post.new post.except( *['postable','tweet_id','out_of_date','postable_type', 'postable_id' ])
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

  desc "pull down the production data and inster it to db"
  task :pull  => :environment do
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

end
