# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  flickr_id          :string(255)
#  flickr_description :text
#  flickr_title       :string(255)
#  url_icon           :string(255)
#  url_big            :string(255)
#  album_id           :integer
#  created_at         :datetime
#  updated_at         :datetime
#  url_original       :string(255)
#

class Photo < ActiveRecord::Base
  belongs_to :album
  validates_presence_of :flickr_id
  include FlickrHelper

  scope :recent, -> { order('created_at DESC').limit(25) }

  def flickr_info
    flickr_access.photos.getInfo :photo_id => flickr_id
  end

  def view_on_flickr_url
    "http://www.flickr.com/photos/sereosonic70/#{flickr_id}/lightbox/"
  end
end
