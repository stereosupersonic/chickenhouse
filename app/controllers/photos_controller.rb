class PhotosController < ApplicationController

  def index
    @photos = Photo.recent
  end

end
