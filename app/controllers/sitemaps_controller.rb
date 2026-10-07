class SitemapsController < ApplicationController
  allow_unauthenticated_access

  def show
    @posts = Post.visible.order(created_at: :desc)
    @events = Event.next_events
  end
end
