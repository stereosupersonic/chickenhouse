class PagesController < ApplicationController
  allow_unauthenticated_access

  before_action :resume_session

  def welcome
    @posts = Post.current.visible.order("created_at desc").paginate page: params[:page], per_page: 5
    @next_event = Event.next_event
  end
end
