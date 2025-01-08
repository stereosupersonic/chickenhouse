# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  admin           :boolean          default(FALSE)
#  email_address   :string
#  password_digest :string
#  slug            :string
#  username        :string
#  created_at      :datetime
#  updated_at      :datetime
#

require "faker"
FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email_address { Faker::Internet.email }
    password { "test" }
    password_confirmation(&:password)
    admin { false }

    factory :admin do
      username { "SuperAdmin" }
      email_address { "admin@henaheisl.de" }
      admin { true }
    end
  end
end
