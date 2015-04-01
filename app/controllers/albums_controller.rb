class AlbumsController < ApplicationController

  def index
    @albums = Album.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  def show
    @album = Album.friendly.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  def year
    @year = params[:year]
    @albums = Album.by_year(@year)
  end

end
