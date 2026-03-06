# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  all_day    :boolean          default(FALSE)
#  content    :text             not null
#  created_at :datetime         not null
#  end_date   :datetime
#  location   :string(255)
#  slug       :string           not null
#  start_date :datetime         not null
#  title      :string(255)      not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#  visible    :boolean          default(TRUE), not null
#
# Indexes
#
#  index_events_on_slug        (slug) UNIQUE
#  index_events_on_start_date  (start_date)
#  index_events_on_user_id     (user_id)
#  index_events_on_visible     (visible)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence(word_count: 3) }
    content { Faker::Lorem.paragraph(sentence_count: 5) }
    user
    visible { true }
    location { "#{Faker::Address.city}, #{Faker::Address.country}" }
    start_date {  Faker::Date.between(from: 2.days.ago, to: 1.year.from_now) }
    all_day { false }
  end
end
