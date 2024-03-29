class PostsController < ApplicationController
  def index
    @posts = Post.visible.order("created_at desc").paginate page: params[:page], per_page: 5

    respond_to do |format|
      format.html
      format.json { render json: @posts }
      format.atom
      format.rss
    end
  end

  def show
    @post = Post.friendly.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end
end
