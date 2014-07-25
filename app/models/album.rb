# == Schema Information
#
# Table name: albums
#
#  id                 :integer          not null, primary key
#  flickr_id          :string(255)
#  flickr_description :text
#  flickr_title       :string(255)
#  iconsmall          :string(255)
#  iconlarge          :string(255)
#  collection_id      :integer
#  created_at         :datetime
#  updated_at         :datetime
#  slug               :string(255)
#  main_photo_id      :integer
#

class Album < ActiveRecord::Base
  extend FriendlyId
  friendly_id :flickr_title, :use => :slugged

  belongs_to :collection
  belongs_to :main_photo, :class_name => "Photo"
  has_many :photos

  include FlickrHelper
  def flickr_info
    flickr_access.photosets.getInfo :photoset_id => flickr_id
  end

  def flickr_photos
    flickr_access.photosets.getPhotos(:photoset_id => flickr_id,
                                      :extras => "original_format, last_update, geo, tags, url_sq, url_t, url_s, url_m, url_o")
  end

  def name
    flickr_title.titleize
  end

  def build_photos
    flickr_photos.to_hash['photo'].each do |fp|
      self.photos.find_or_create_by_flickr_id(fp['id']) do |photo|
        #TODO more url
        photo.url_icon = fp['url_sq']
        photo.url_icon = fp['url_t']
        photo.url_icon = fp['url_s']
        photo.url_icon = fp['url_m']
        photo.url_icon = fp['url_o']
      end
    end
  end

  #after_create :create_post
  def create_post
    content = %(<div class="collection">
      <p>
      <a href='#{Rails.application.routes.url_helpers.album_path(self)}' target="" rel=""><img alt="" src='#{self.main_photo.try(:url_small).presence || iconsmall}' class="center-block img-thumbnail"></a>
      <a href='#{Rails.application.routes.url_helpers.album_path(self)}' target="" rel="">Hier gehts zu den Bildern</a>
      </p>
      </div>)

    Post.create(:title => " Neue Bilder: #{name}", :content => content, :created_at => self.created_at, :album_id => self.id )

  end

end
