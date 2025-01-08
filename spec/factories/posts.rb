# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  attachment_content_type :string
#  attachment_file_name    :string
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  content                 :text
#  content_type            :string           default("article")
#  display_type            :string           default("textile")
#  intern                  :boolean          default(FALSE)
#  media                   :text
#  media_type              :string
#  out_of_date             :datetime
#  slug                    :string
#  title                   :string
#  twitter_export          :boolean          default(TRUE)
#  visible                 :boolean          default(TRUE)
#  created_at              :datetime
#  updated_at              :datetime
#  album_id                :integer
#  user_id                 :integer
#
# Indexes
#
#  index_posts_on_album_id  (album_id)
#  index_posts_on_intern    (intern)
#  index_posts_on_visible   (visible)
#

# Read about factories at https://github.com/thoughtbot/factory_girl
require "faker"
FactoryBot.define do
  factory :post do
    content { Faker::Lorem.sentence }
    title { "My Coole Post" }
    user
  end
end
