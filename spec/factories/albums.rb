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
#  collection_id      :integer          indexed
#  created_at         :datetime
#  updated_at         :datetime
#  slug               :string(255)
#  main_photo_id      :integer
#  visible            :boolean          default(TRUE), indexed
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :album do
    flickr_id 1
    flickr_description "MyText"
    flickr_title "MyString"
    iconsmall "MyString"
    iconlarge "MyString"
  end
end
