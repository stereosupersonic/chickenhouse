class SitemapsController < ApplicationController
  allow_unauthenticated_access

  def show
    @posts = Post.order(created_at: :desc)
    @events = Event.next_events

    respond_to do |format|
      format.xml
    end
  end
end
