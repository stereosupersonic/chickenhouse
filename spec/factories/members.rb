# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  birthday   :date
#  city       :string
#  email      :string
#  first_name :string
#  last_name  :string
#  mobil      :string
#  occurs_at  :date
#  plz        :string
#  street     :string
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
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
