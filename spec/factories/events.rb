# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  all_day    :boolean
#  content    :text
#  end_date   :datetime
#  location   :string
#  slug       :string
#  start_date :datetime
#  title      :string
#  visible    :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#
# Indexes
#
#  index_events_on_start_date  (start_date)
#  index_events_on_visible     (visible)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence(word_count: 3) }
    content { Faker::Lorem.paragraph(sentence_count: 5) }
    user
    location { "#{Faker::Address.city}, #{Faker::Address.country}" }
    start_date {  Faker::Date.between(from: 2.days.ago, to: 1.year.from_now) }
    all_day { false }
  end
end
