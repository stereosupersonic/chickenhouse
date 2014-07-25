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
#  created_at         :datetime
#  updated_at         :datetime
#  url_original       :string(255)
#  slug               :string(255)
#  url_small          :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    flickr_id 1
    flickr_description "MyText"
    flickr_title "MyString"
    url_icon "MyString"
    url_big "MyString"
  end
end
