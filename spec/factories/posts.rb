# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  content                 :text
#  title                   :string(255)
#  intern                  :boolean
#  user_id                 :integer
#  postable_id             :integer          indexed
#  postable_type           :string(20)       indexed, indexed => [out_of_date]
#  created_at              :datetime
#  updated_at              :datetime
#  out_of_date             :datetime         indexed => [postable_type], indexed
#  tweet_id                :integer
#  tags                    :text
#  content_type            :string(255)      default("article")
#  media                   :text
#  media_type              :string(255)      default("")
#  twitter_export          :boolean          default(TRUE)
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
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
