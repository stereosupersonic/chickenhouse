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
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Photo < ActiveRecord::Base
  belongs_to :album
  include FlickrHelper
  def flickr_info
    flickr_access.photos.getInfo :photo_id => flickr_id
  end
end
