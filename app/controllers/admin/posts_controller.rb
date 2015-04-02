class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /admin/posts
  def index
    @posts = Post.order('created_at desc').paginate :page => params[:page], :per_page => 10
  end

  # GET /admin/posts/1
  def show
  end

  # GET /admin/posts/new
  def new
    @post = Post.new
  end

  # GET /admin/posts/1/edit
  def edit
  end

  # POST /admin/posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_posts_url, notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /admin/posts/1
  def update
    if @post.update(post_params)
      redirect_to admin_posts_url, notice: 'Post was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/posts/1
  def destroy
    @post.destroy
    redirect_to admin_posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :content, :content_type, :media, :intern, :attachment, :visible, :created_at)
    end
end
