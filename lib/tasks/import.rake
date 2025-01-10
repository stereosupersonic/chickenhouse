# create rake task to import data from json file
namespace :import do
  desc "Import data from json file"
  task data: :environment do
    Event.delete_all
    Post.delete_all
    events = JSON.parse File.read("db/data/events.json")
    posts = JSON.parse File.read("db/data/posts.json")

    events.each do |record|
      event = Event.new(record)
      event.user_id = 1 if event.user_id.blank?
      event.save validate: false
    end

    posts.each do |record|
      post = Post.new(record)
      post.user_id = 1 if post.user_id.blank?
      post.save validate: false
    end
    puts "created #{events.count} events and #{posts.count} posts"
  end
end
