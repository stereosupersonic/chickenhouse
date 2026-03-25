class PagesController < ApplicationController
  allow_unauthenticated_access

  before_action :resume_session

  def welcome
    @pagy, @current_posts = pagy(Post.current.visible.order("created_at desc"))
    @next_event = Event.next_event
  end

  def contact
  end

  def bilder
    respond_to do |format|
      format.html
      format.any { head :not_found }
    end
  end

  def exception
    raise "This is a test exception to verify error reporting via Rollbar, Sentry, etc."
  end
end
