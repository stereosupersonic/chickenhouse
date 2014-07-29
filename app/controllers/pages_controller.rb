class PagesController < ApplicationController
  def welcome
    @posts = Post.visible.order("created_at desc").paginate :page => params[:page], :per_page => 5
    @next_event = Event.next_event
    @next_events = Event.next_events.limit(3)
  end
end
