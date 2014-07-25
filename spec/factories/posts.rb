# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  content                 :text
#  title                   :string(255)
#  intern                  :boolean          default(FALSE)
#  user_id                 :integer
#  media                   :text
#  media_type              :string(255)
#  out_of_date             :datetime
#  content_type            :string(255)      default("article")
#  twitter_export          :boolean          default(TRUE)
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  created_at              :datetime
#  updated_at              :datetime
#  slug                    :string(255)
#  album_id                :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
FactoryGirl.define do
  factory :post do
    content  { Faker::Lorem.sentence }
    title  'My Coole Post'
    #user_id 1
  end
end
