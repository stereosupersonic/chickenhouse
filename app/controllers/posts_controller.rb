class PostsController < ApplicationController
  allow_unauthenticated_access only: %i[index show]
  def index
    posts = Post.readable_by(Current.user).order(created_at: :desc)
    posts = Posts::Search.call(query: params[:q], scope: posts) if params[:q].present?
    @pagy, @posts = pagy(posts)

    respond_to do |format|
      format.html
      format.atom
    end
  end

  def show
    @post = Post.readable_by(Current.user).friendly.find params[:id]
  end
end
