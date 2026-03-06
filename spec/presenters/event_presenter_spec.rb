require "rails_helper"

RSpec.describe EventPresenter, type: :presenter do
  describe "#html_content" do
    it "formats content using simple_format and sanitizes it" do
      event = create(:event, content: "Line 1\n\nLine 2")
      presenter = described_class.new(event)
      html_content = presenter.html_content
      expect(html_content).to include("<p>Line 1</p>")
      expect(html_content).to include("<p>Line 2</p>")
    end

    it "sanitizes dangerous HTML" do
      event = create(:event, content: "<script>alert('xss')</script>Safe content")
      presenter = described_class.new(event)
      html_content = presenter.html_content
      expect(html_content).not_to include("<script>")
      expect(html_content).to include("Safe content")
    end

    it "auto-links URLs" do
      event = create(:event, content: "Check https://example.com for details")
      presenter = described_class.new(event)
      html_content = presenter.html_content
      expect(html_content).to include('href="https://example.com"')
      expect(html_content).to include('target="_blank"')
      expect(html_content).to include('rel="noopener noreferrer"')
    end

    it "handles nil content" do
      event = build(:event, content: nil)
      presenter = described_class.new(event)
      expect { presenter.html_content }.not_to raise_error
    end
  end

  describe "#formatted_start_date" do
    it "formats start_date for regular events" do
      event = create(:event, start_date: Time.zone.parse("2026-06-15 18:00"), all_day: false)
      presenter = described_class.new(event)

      expect(presenter.formatted_start_date).to eq(I18n.l(event.start_date, format: :default))
    end

    it "formats start_date for all-day events" do
      event = create(:event, start_date: Time.zone.parse("2026-06-15 00:00"), all_day: true)
      presenter = described_class.new(event)

      expect(presenter.formatted_start_date).to eq(I18n.l(event.start_date, format: :day))
    end

    it "returns empty string when start_date is blank" do
      event = build(:event)
      allow(event).to receive(:start_date).and_return(nil)
      presenter = described_class.new(event)

      expect(presenter.formatted_start_date).to eq("")
    end
  end

  describe "#formatted_end_date" do
    it "formats end_date for regular events" do
      event = create(:event, start_date: 1.week.from_now, end_date: Time.zone.parse("2026-06-15 20:00"), all_day: false)
      presenter = described_class.new(event)

      expect(presenter.formatted_end_date).to eq(I18n.l(event.end_date, format: :default))
    end

    it "formats end_date for all-day events" do
      event = create(:event, start_date: 1.week.from_now, end_date: Time.zone.parse("2026-06-16 00:00"), all_day: true)
      presenter = described_class.new(event)

      expect(presenter.formatted_end_date).to eq(I18n.l(event.end_date, format: :day))
    end

    it "returns empty string when end_date is blank" do
      event = create(:event, end_date: nil)
      presenter = described_class.new(event)

      expect(presenter.formatted_end_date).to eq("")
    end
  end
end
