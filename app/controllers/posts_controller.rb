class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  before_action :resume_session, only: %i[index show]
  def index
    posts = Post.visible.order(created_at: :desc)
    posts = Posts::Search.call(query: params[:q], scope: posts).result if params[:q].present?
    @pagy, @posts = pagy(posts)

    respond_to do |format|
      format.html
      format.atom
      format.rss
    end
  end

  def show
    @post = Post.friendly.find params[:id]
  end
end
