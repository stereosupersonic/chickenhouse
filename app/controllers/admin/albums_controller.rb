class Admin::AlbumsController < Admin::BaseController
  before_action :set_album, only: [:show, :edit, :update, :destroy, :reload_from_flickr]

  # GET /admin/photos
  def index
    @albums = Album.order("created_at DESC").paginate page: params[:page], per_page: 20
  end

  # GET /admin/photos/1
  def show
  end

  # GET /admin/photos/new
  def new
    @album = Album.new
  end

  # GET /admin/photos/1/edit
  def edit
  end

  # PATCH/PUT /admin/photos/1
  def update
    if @album.update(album_params)
      redirect_to [:admin, :albums], notice: "Albums was successfully updated."
    else
      render action: "edit"
    end
  end

  def reload_from_flickr
    @album.reload_from_flickr!
    redirect_to [:admin, :albums], notice: "Albums was successfully reload from flickr."
  end

  # DELETE /admin/photos/1
  def destroy
    @album.destroy
    redirect_to [:admin, :photos], notice: "Photo was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_album
    @album = Album.friendly.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def album_params
    params.require(:album).permit(:flickr_description, :flickr_title, :visible, :created_at)
  end
end
