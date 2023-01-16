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

require "rails_helper"

describe Event do
  describe "validation" do
    it "builds a valid factory" do
      expect(build(:event)).to be_valid
    end

    it "not be valid without a title" do
      event = build(:event, title: nil)
      expect(event).not_to be_valid
      expect(event.errors[:title]).to be_present
    end
  end

  describe "next_event" do
    it "is the next" do
      event = create(:event, start_date: 1.day.since)

      expect(described_class.next_event).to eq event
    end

    it "does not load events in the past" do
      create(:event, start_date: 1.day.ago)

      expect(described_class.next_event).to be_nil
    end

    it "loads the nearest event" do
      create(:event, start_date: 2.days.since)
      event = create(:event, start_date: 1.day.since)
      create(:event, start_date: 1.day.ago)

      expect(described_class.next_event).to eq event
    end
  end

  describe "next_events" do
    it "is the next" do
      event = create(:event, start_date: 1.day.since)

      expect(described_class.next_events).to eq [event]
    end

    it "does not load events in the past" do
      create(:event, start_date: 1.day.ago)

      expect(described_class.next_events).to be_empty
    end

    it "loads the nearest event" do
      event_1 = create(:event, start_date: 2.days.since)
      event = create(:event, start_date: 1.day.since)
      create(:event, start_date: 1.day.ago)

      expect(described_class.next_events).to eq [event, event_1]
    end
  end
end
