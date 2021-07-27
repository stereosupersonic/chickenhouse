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

FactoryBot.define do
  factory :collection do
    flickr_id { 1 }
    flickr_description { "my destcription" }
    flickr_title { "my flickr_title" }
    iconsmall { "my iconsmall" }
    iconlarge { "my iconlarge" }
  end
end
