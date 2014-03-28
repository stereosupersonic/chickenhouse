class PhotosController < ApplicationController

  def index

    @collections   = Collection.all
  end

    def recent
    @recent = Photo.recent
  end


  def show
     @photo = Photo.find params[:id]
  end

end
