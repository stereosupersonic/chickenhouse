# == Schema Information
#
# Table name: albums
#
#  id                 :integer          not null, primary key
#  flickr_description :text
#  flickr_title       :string
#  iconlarge          :string
#  iconsmall          :string
#  slug               :string
#  visible            :boolean          default(TRUE)
#  created_at         :datetime
#  updated_at         :datetime
#  collection_id      :integer
#  flickr_id          :string
#  main_photo_id      :integer
#
# Indexes
#
#  index_albums_on_collection_id  (collection_id)
#  index_albums_on_visible        (visible)
#

require 'rails_helper'

describe Album do
  pending "add some examples to (or delete) #{__FILE__}"
end
