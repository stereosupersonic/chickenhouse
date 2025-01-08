class PagesController < ApplicationController
  allow_unauthenticated_access

  before_action :resume_session

  def welcome
    @pagy, @current_posts = pagy(Post.current.visible.order("created_at desc"))
    @next_event = Event.next_event
  end
end
