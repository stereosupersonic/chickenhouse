# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  admin           :boolean          default(FALSE), not null
#  email_address   :string           not null
#  password_digest :string           not null
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email_address  (email_address) UNIQUE
#

require "faker"
FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "#{Faker::Internet.username}#{n}" }
    sequence(:email_address) { |n| "user#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }

    factory :admin do
      username { "SuperAdmin" }
      email_address { "admin@henaheisl.de" }
      admin { true }
    end
  end
end
