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

require 'rails_helper'

describe Event do
  describe 'validation' do
    it "should build a valid factory" do
      build(:event).should be_valid
    end

    it "not be valid without a title" do
      build(:event,:title => nil).should have(1).errors_on(:title)
    end
  end

  describe "next_event" do

    it "should be the next" do
      event = create(:event, :start_date => 1.day.since)
      Event.next_event.should == event
    end

    it "should not load events in the past" do
      event = create(:event, :start_date => 1.day.ago)
      Event.next_event.should be_nil
    end

    it "should  load the nearest event" do
      event_1 = create(:event, :start_date => 2.day.since)
      event  = create(:event, :start_date => 1.day.since)
      event_3 = create(:event, :start_date => 1.day.ago)
      Event.next_event.should == event
    end
  end

  describe "next_events" do

    it "should be the next" do
      event = create(:event, :start_date => 1.day.since)
      Event.next_events.should == [event]
    end

    it "should not load events in the past" do
      event = create(:event, :start_date => 1.day.ago)
      Event.next_events.should be_empty
    end

    it "should load the nearest event" do
      event_1 = create(:event, :start_date => 2.day.since)
      event  = create(:event, :start_date => 1.day.since)
      event_3 = create(:event, :start_date => 1.day.ago)
      Event.next_events.should == [event,event_1]
    end

  end
end
