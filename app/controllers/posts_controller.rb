class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.visible.order('created_at DESC')

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
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end


end
