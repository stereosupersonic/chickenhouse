class SitemapsController < ApplicationController
  allow_unauthenticated_access

  def show
    @posts = Post.published.order(created_at: :desc)
    @events = Event.next_events
  end
end
