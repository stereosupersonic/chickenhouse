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
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Album < ActiveRecord::Base
  belongs_to :collection
  has_many :photos

  include FlickrHelper
  def flickr_info
    flickr_access.photosets.getInfo :photoset_id => flickr_id
  end

  def flickr_photos
    flickr_access.photosets.getPhotos(:photoset_id => flickr_id,
                                      :extras => "original_format, last_update, geo, tags, url_sq, url_t, url_s, url_m, url_o")
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
end
