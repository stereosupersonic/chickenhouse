class Admin::PhotosController < Admin::BaseController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /admin/photos
  def index
    @photos = Photo.order('created_at DESC').paginate :page => params[:page], :per_page => 20
  end

  # GET /admin/photos/1
  def show
  end

  # GET /admin/photos/new
  def new
    @photo = Photo.new
  end

  # GET /admin/photos/1/edit
  def edit
  end

  # PATCH/PUT /admin/photos/1
  def update
    if @photo.update(photo_params)
      redirect_to [:admin, :photos], notice: 'Photo was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/photos/1
  def destroy
    @photo.destroy
    redirect_to [:admin, :photos], notice: 'Photo was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def photo_params
      params.require(:photo).permit(:flickr_id, :flickr_description, :flickr_title, :url_icon, :url_big, :album_id, :url_original)
    end
end
