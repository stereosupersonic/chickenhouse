require "rails_helper"

RSpec.describe PostPresenter, type: :presenter do
  describe "#html_content for old_content" do
    context "when display_type is raw" do
      it "returns content as html_safe" do
        post = create(:post, old_content: "<p>Raw HTML</p>", display_type: "raw")
        presenter = described_class.new(post)
        html_content = presenter.html_content
        expect(html_content).to eq("<p>Raw HTML</p>")
        expect(html_content).to be_html_safe
      end
    end

    context "when display_type is not raw" do
      it "returns content as html_safe" do
        post = create(:post, old_content: "Regular content", display_type: "textile")
        presenter = described_class.new(post)
        html_content = presenter.html_content
        expect(html_content).to eq("Regular content")
        expect(html_content).to be_html_safe
      end
    end
  end

  describe "#html_content rich text" do
    it "returns content as html_safe" do
      post = create(:post, content: "# Regular content")
      presenter = described_class.new(post)
      html_content = presenter.html_content
      expect(html_content).to be_a(ActionText::RichText)
    end
  end
end
