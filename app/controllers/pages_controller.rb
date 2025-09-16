class PagesController < ApplicationController
  allow_unauthenticated_access

  before_action :resume_session

  def welcome
    @pagy, current_posts = pagy(Post.current.visible.order("created_at desc"))
    @current_posts = PostPresenter.wrap(current_posts)
    next_event = Event.next_event
    @next_event = next_event ? EventPresenter.new(next_event) : nil
  end

  def exception
    raise "This is a test exception to verify error reporting via Rollbar, Sentry, etc."
  end
end
