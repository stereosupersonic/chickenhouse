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

FactoryGirl.define do
  factory :event do
    title "MyString"
    content "MyText"
    user_id 1
    location "MyString"
    start_date {1.day.since }
    end_date { Time.now }
    all_day false
  end
end
