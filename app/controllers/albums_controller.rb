class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def show
    @album = Album.friendly.find(params[:id])
  end

  def year
    @year = params[:year]
    @albums = Album.by_year(@year)
  end
end
