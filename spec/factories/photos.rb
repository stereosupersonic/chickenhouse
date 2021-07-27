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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :photo do
    flickr_id { 1 }
    flickr_description { "my flickr_description" }
    flickr_title { "my flickr_title" }
    url_icon { "my url_icon" }
    url_big { "my url_big" }
  end
end
