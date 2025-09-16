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

    it "handles nil content" do
      event = build(:event, content: nil)
      presenter = described_class.new(event)
      expect { presenter.html_content }.not_to raise_error
    end
  end
end
