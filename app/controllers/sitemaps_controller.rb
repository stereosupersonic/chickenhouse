class SitemapsController < ApplicationController
  allow_unauthenticated_access

  def show
    @posts = Post.order(created_at: :desc)
    @events = Event.order(start_date: :desc)

    respond_to do |format|
      format.xml
    end
  end
end
