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

require 'rails_helper'

describe Photo do
  pending "add some examples to (or delete) #{__FILE__}"
end
