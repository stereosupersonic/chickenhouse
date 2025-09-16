class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :resume_session, only: %i[ index show ]
  def index
    @pagy, posts = pagy(Post.visible.order("created_at desc"))
    @posts = PostPresenter.wrap(posts)

    respond_to do |format|
      format.html
      format.atom
      format.rss
    end
  end

  def show
    post = Post.friendly.find params[:id]
    @post = PostPresenter.new(post)
  end
end
