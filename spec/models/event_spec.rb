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

RSpec.describe Event, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    subject { build(:event) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(255) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content).is_at_most(10_000) }
    it { is_expected.to validate_length_of(:location).is_at_most(255) }
    # it { should validate_presence_of(:slug) } # Slug is auto-generated
    it { is_expected.to validate_uniqueness_of(:slug) }

    describe "title validation" do
      it "builds a valid factory" do
        expect(build(:event)).to be_valid
      end

      it "is not valid without a title" do
        event = build(:event, title: nil)
        expect(event).not_to be_valid
        expect(event.errors[:title]).to be_present
      end

      it "is not valid with empty title" do
        event = build(:event, title: "")
        expect(event).not_to be_valid
        expect(event.errors[:title]).to include("muss ausgefüllt werden")
      end

      it "is not valid with title longer than 255 characters" do
        long_title = "a" * 256
        event = build(:event, title: long_title)
        expect(event).not_to be_valid
        expect(event.errors[:title]).to be_present
      end
    end

    describe "content validation" do
      it "is not valid without content" do
        event = build(:event, content: nil)
        expect(event).not_to be_valid
        expect(event.errors[:content]).to include("muss ausgefüllt werden")
      end

      it "is not valid with content longer than 10,000 characters" do
        long_content = "a" * 10_001
        event = build(:event, content: long_content)
        expect(event).not_to be_valid
        expect(event.errors[:content]).to be_present
      end

      it "accepts content up to 10,000 characters" do
        long_content = "a" * 10_000
        event = build(:event, content: long_content)
        expect(event).to be_valid
      end
    end

    describe "location validation" do
      it "is valid without location" do
        event = build(:event, location: nil)
        expect(event).to be_valid
      end

      it "is not valid with location longer than 255 characters" do
        long_location = "a" * 256
        event = build(:event, location: long_location)
        expect(event).not_to be_valid
        expect(event.errors[:location]).to be_present
      end

      it "accepts location up to 255 characters" do
        location = "a" * 255
        event = build(:event, location: location)
        expect(event).to be_valid
      end
    end
  end

  describe "scopes" do
    let(:user) { create(:user) }

    before do
      create(:event, visible: true, start_date: 1.day.from_now, user: user, title: "Future Event")
      create(:event, visible: false, start_date: 2.days.from_now, user: user, title: "Hidden Future Event")
      create(:event, visible: true, start_date: 1.day.ago, user: user, title: "Past Event")
    end

    describe ".visible" do
      it "returns only visible events" do
        visible_events = described_class.visible
        expect(visible_events.count).to eq(2)
        expect(visible_events.pluck(:title)).to include("Future Event", "Past Event")
        expect(visible_events.pluck(:title)).not_to include("Hidden Future Event")
      end
    end

    describe ".next_events" do
      it "returns only future visible events ordered by start_date" do
        next_events = described_class.next_events
        expect(next_events.count).to eq(1)
        expect(next_events.first.title).to eq("Future Event")
      end

      it "excludes past events" do
        create(:event, start_date: 1.day.ago, user: user, title: "Past Event 2")
        expect(described_class.next_events.pluck(:title)).not_to include("Past Event", "Past Event 2")
      end

      it "excludes hidden events" do
        expect(described_class.next_events.pluck(:title)).not_to include("Hidden Future Event")
      end

      it "orders events by start_date" do
        create(:event, start_date: 2.days.from_now, user: user, title: "Event 1")
        create(:event, start_date: 1.day.from_now, user: user, title: "Event 2")

        next_events = described_class.next_events
        expect(next_events.map(&:title)).to eq([ "Future Event", "Event 2", "Event 1" ])
      end
    end
  end

  describe ".next_event" do
    let(:user) { create(:user) }

    it "returns the next upcoming event" do
      event = create(:event, start_date: 1.day.from_now, user: user)
      expect(described_class.next_event).to eq(event)
    end

    it "does not return events in the past" do
      create(:event, start_date: 1.day.ago, user: user)
      expect(described_class.next_event).to be_nil
    end

    it "returns the nearest event when multiple exist" do
      create(:event, start_date: 2.days.from_now, user: user, title: "Later Event")
      nearest_event = create(:event, start_date: 1.day.from_now, user: user, title: "Nearest Event")
      create(:event, start_date: 1.day.ago, user: user, title: "Past Event")

      expect(described_class.next_event).to eq(nearest_event)
    end

    it "does not return hidden events" do
      create(:event, start_date: 1.day.from_now, visible: false, user: user)
      expect(described_class.next_event).to be_nil
    end
  end

  describe "friendly_id" do
    it "generates slug from title" do
      event = create(:event, title: "My Awesome Event")
      expect(event.slug).to eq("my-awesome-event")
    end

    it "handles duplicate titles" do
      user = create(:user)
      create(:event, title: "Duplicate Title", user: user)
      event2 = create(:event, title: "Duplicate Title", user: user)
      expect(event2.slug).to start_with("duplicate-title-")
    end

    it "can be found by slug" do
      event = create(:event, title: "Findable Event")
      found_event = described_class.friendly.find(event.slug)
      expect(found_event).to eq(event)
    end
  end

  describe "#html_content" do
    it "formats content using simple_format and sanitizes it" do
      event = create(:event, content: "Line 1\n\nLine 2")
      html_content = event.html_content
      expect(html_content).to include("<p>Line 1</p>")
      expect(html_content).to include("<p>Line 2</p>")
    end

    it "sanitizes dangerous HTML" do
      event = create(:event, content: "<script>alert('xss')</script>Safe content")
      html_content = event.html_content
      expect(html_content).not_to include("<script>")
      expect(html_content).to include("Safe content")
    end

    it "handles nil content" do
      event = build(:event, content: nil)
      expect { event.html_content }.not_to raise_error
    end
  end

  describe "default values" do
    it "sets visible to true by default" do
      event = described_class.new
      expect(event.visible).to be true
    end

    it "allows all_day to be nil" do
      event = create(:event, all_day: nil)
      expect(event.all_day).to be_nil
    end
  end

  describe "timestamps and dates" do
    it "can store start_date and end_date" do
      start_time = 1.day.from_now
      end_time = 2.days.from_now
      event = create(:event, start_date: start_time, end_date: end_time)

      expect(event.start_date).to be_within(1.second).of(start_time)
      expect(event.end_date).to be_within(1.second).of(end_time)
    end

    it "can be an all-day event" do
      event = create(:event, all_day: true, start_date: Date.current)
      expect(event.all_day).to be true
    end
  end

  describe "factory" do
    it "creates a valid event" do
      event = build(:event)
      expect(event).to be_valid
    end

    it "creates an event with associated user" do
      event = create(:event)
      expect(event.user).to be_present
      expect(event.user).to be_a(User)
    end
  end
end
