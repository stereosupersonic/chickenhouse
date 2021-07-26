# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  admin           :boolean          default(FALSE)
#  email           :string
#  password_digest :string
#  slug            :string
#  username        :string
#  created_at      :datetime
#  updated_at      :datetime
#

require 'faker'
FactoryGirl.define do
  factory :user do
    username  { Faker::Name.last_name }
    email     { Faker::Internet.email }
    password  { 1234 }
    password_confirmation { |r| r.password }
    admin false

    factory :admin do
      username 'SuperAdmin'
      email  'admin@henaheisl.de'
      admin true
    end
  end
end
