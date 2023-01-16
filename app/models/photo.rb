# == Schema Information
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  flickr_description :text
#  flickr_title       :string
#  slug               :string
#  taken_at           :datetime
#  url_big            :string
#  url_icon           :string
#  url_original       :string
#  url_small          :string
#  visible            :boolean          default(TRUE)
#  created_at         :datetime
#  updated_at         :datetime
#  album_id           :integer
#  flickr_id          :string
#
# Indexes
#
#  index_photos_on_album_id  (album_id)
#  index_photos_on_taken_at  (taken_at)
#  index_photos_on_visible   (visible)
#

class Photo < ApplicationRecord
  extend FriendlyId
  friendly_id :flickr_title, use: :slugged

  belongs_to :album
  validates :flickr_id, presence: true

  # include FlickrHelper
  scope :visible, -> { where(visible: true) }

  scope :recent, -> { visible.order("taken_at DESC").limit(25) }

  def flickr_info
    flickr_access.photos.getInfo photo_id: flickr_id
  end

  def name
    flickr_title.titleize
  end

  def view_on_flickr_url
    "http://www.flickr.com/photos/sereosonic70/#{flickr_id}/lightbox/"
  end
end
