# == Schema Information
#
# Table name: collections
#
#  id                 :integer          not null, primary key
#  flickr_id          :string(255)
#  flickr_description :text
#  flickr_title       :string(255)
#  iconsmall          :string(255)
#  iconlarge          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Collection < ActiveRecord::Base
  has_many :albums
  extend FlickrHelper
  include FlickrHelper

  def flickr_info
    flickr_access.collections.getInfo :collection_id => flickr_id
  end

  def self.build_from_flickr
    flickr_access.collections.getTree.to_hash['collection'].find {|c|c.title == 'henaheisl'}.to_hash['collection'].to_a.each do |collection|

      Collection.find_or_create_by_flickr_id(collection['id']) do | col |
        col.flickr_title          = collection['title']
        col.flickr_description    = collection['description']
        col.iconsmall             = collection['iconsmall']
        col.iconlarge             = collection['iconlarge']
        collection['set'].each do |set |
          col.albums.build do |album|
            album.flickr_id             = set['id']
            album.flickr_title          = set['title']
            album.flickr_description    = set['description']
            album.iconsmall             = set['iconsmall']
            album.iconlarge             = set['iconlarge']
          end
        end
      end
    end
  end
end
