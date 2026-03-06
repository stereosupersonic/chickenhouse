class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[show edit update destroy]

  # GET /admin/posts
  def index
    @pagy, @posts = pagy(Post.order("created_at desc"), limit: 25)
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params.merge(user: Current.user))

    if @post.save
      redirect_to admin_posts_url, notice: "Post was successfully created."
    else
      render action: "new"
    end
  end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_url, notice: "Post was successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    @post.destroy

    redirect_to admin_posts_url, notice: "Post was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.friendly.find(params[:id])
  end

  def post_params
    params.expect(post: [ :title, :old_content, :old_content_type, :content, :media, :intern, :visible, :created_at, :display_type ])
  end
end
