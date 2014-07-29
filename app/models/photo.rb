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
#  album_id           :integer          indexed
#  created_at         :datetime
#  updated_at         :datetime
#  url_original       :string(255)
#  slug               :string(255)
#  url_small          :string(255)
#  taken_at           :datetime         indexed
#  visible            :boolean          default(TRUE), indexed
#

class Photo < ActiveRecord::Base
  extend FriendlyId
  friendly_id :flickr_title, :use => :slugged

  belongs_to :album
  validates_presence_of :flickr_id

  include FlickrHelper
  scope :visible, -> { where(:visible => true) }

  scope :recent,  -> { visible.order('taken_at DESC').limit(25) }

  def flickr_info
    flickr_access.photos.getInfo :photo_id => flickr_id
  end

  def name
    flickr_title.titleize
  end

  def view_on_flickr_url
    "http://www.flickr.com/photos/sereosonic70/#{flickr_id}/lightbox/"
  end
end
