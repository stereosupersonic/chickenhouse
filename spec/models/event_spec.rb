# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  user_id    :integer
#  location   :string(255)
#  start_date :datetime
#  end_date   :datetime
#  all_day    :boolean
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

require 'spec_helper'

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
