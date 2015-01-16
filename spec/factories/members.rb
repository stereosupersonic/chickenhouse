# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  street     :string(255)
#  plz        :string(255)
#  city       :string(255)
#  mobil      :string(255)
#  email      :string(255)
#  occurs_at  :date
#  birthday   :date
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    first_name "MyString"
    last_name "MyString"
    street "MyString"
    plz "MyString"
    city "MyString"
    mobil "MyString"
    email "MyString"
    occurs_at "2015-01-16"
    birthday "2015-01-16"
  end
end
