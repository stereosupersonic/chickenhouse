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
#  slug               :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collection do
    flickr_id 1
    flickr_description "MyText"
    flickr_title "MyString"
    iconsmall "MyString"
    iconlarge "MyString"
  end
end
