# == Schema Information
#
# Table name: collections
#
#  id                 :integer          not null, primary key
#  flickr_description :text
#  flickr_title       :string
#  iconlarge          :string
#  iconsmall          :string
#  slug               :string
#  created_at         :datetime
#  updated_at         :datetime
#  flickr_id          :string
#

class Collection < ApplicationRecord
  extend FriendlyId
  friendly_id :flickr_title, use: :slugged
  # extend FlickrHelper

  has_many :albums, -> { where(visible: true).order("created_at") }

  def flickr_info
    flickr_access.collections.getInfo collection_id: flickr_id
  end

  def name
    flickr_title.titleize
  end
end
