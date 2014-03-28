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
  extend FlickrHelper

  has_many :albums

  def flickr_info
    flickr_access.collections.getInfo :collection_id => flickr_id
  end

  def name
    flickr_title.titleize
  end

end
