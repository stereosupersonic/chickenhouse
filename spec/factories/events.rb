# == Schema Information
#
# Table name: events
#
#  id         :bigint(8)        not null, primary key
#  all_day    :boolean          default(FALSE)
#  content    :text             not null
#  end_date   :datetime
#  location   :string(255)
#  slug       :string           not null, uniquely indexed
#  start_date :datetime         not null, indexed
#  title      :string(255)      not null
#  visible    :boolean          default(TRUE), not null, indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null, indexed
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
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
