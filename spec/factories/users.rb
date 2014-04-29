# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#  slug            :string(255)
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
