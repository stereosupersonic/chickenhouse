# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  body       :text
#  email      :string
#  name       :string
#  subject    :string
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :contact do
    subject { "cooler Verein" }
    body { "whats up" }
    email { "mrcool@sample.com" }
    name { "mr cool" }
  end
end
