# == Schema Information
#
# Table name: posts
#
#  id               :bigint           not null, primary key
#  display_type     :string(255)      default("textile")
#  intern           :boolean          default(FALSE)
#  media            :text
#  old_content      :text
#  old_content_type :string(255)      default("article")
#  slug             :string(255)
#  title            :string(255)      not null
#  visible          :boolean          default(TRUE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#  index_posts_on_visible  (visible)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl
require "faker"
FactoryBot.define do
  factory :post do
    content { Faker::Lorem.paragraphs(number: 2).join("\n\n") }
    title { Faker::Book.title }
    user
  end
end
