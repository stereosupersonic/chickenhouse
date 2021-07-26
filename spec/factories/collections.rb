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
