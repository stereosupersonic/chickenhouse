# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  body       :text
#  email      :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    subject "cooler Verein"
    body    "whats up"
    email   "mrcool@sample.com"
    name    "mr cool"
  end
end
