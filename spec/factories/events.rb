# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  location   :string(255)
#  start_date :datetime         indexed
#  end_date   :datetime
#  all_day    :boolean
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
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
