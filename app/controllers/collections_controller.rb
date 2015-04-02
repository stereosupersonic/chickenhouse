class CollectionsController < ApplicationController

  def index
    @collections = Collection.all
    @recent_photo  = Photo.recent.first
  end

  def show
    @collection = Collection.friendly.find(params[:id])
  end

  def new
    @collection = Collection.new
  end

  def edit
    @collection = Collection.friendly.find(params[:id])
  end

  def create
    @collection = Collection.new(params[:collection])

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: 'Collection was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @collection = Collection.friendly.find(params[:id])
    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @collection = Collection.friendly.find(params[:id])
    @collection.destroy

    respond_to do |format|
      format.html { redirect_to collections_url }
    end
  end
end
