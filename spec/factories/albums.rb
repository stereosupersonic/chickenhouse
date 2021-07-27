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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :album do
    flickr_id { 1 }
    flickr_description { "MyText" }
    flickr_title { "MyString" }
    iconsmall { "MyString" }
    iconlarge { "MyString" }
  end
end
