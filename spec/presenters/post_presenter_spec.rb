require "rails_helper"

RSpec.describe PostPresenter, type: :presenter do
  describe "#html_content for old_content" do
    it "returns sanitized old_content as html_safe" do
      post = create(:post, old_content: "<p>Raw HTML</p>")
      presenter = described_class.new(post)
      html_content = presenter.html_content

      expect(html_content).to eq("<p>Raw HTML</p>")
      expect(html_content).to be_html_safe
    end
  end

  describe "#html_content rich text" do
    it "returns content as html_safe" do
      post = create(:post, content: "# Regular content")
      presenter = described_class.new(post)
      html_content = presenter.html_content

      expect(html_content).to be_a(ActionText::RichText)
      expect(html_content.to_plain_text).to eq("# Regular content")
    end
  end

  describe "#meta_description" do
    it "returns truncated plain text from rich text content" do
      post = create(:post, content: "This is a test post with some content for meta description purposes.")
      presenter = described_class.new(post)

      expect(presenter.meta_description).to include("This is a test post")
      expect(presenter.meta_description.length).to be <= 160
    end

    it "returns truncated plain text from old_content" do
      post = create(:post, old_content: "<p>Legacy HTML content here</p>")
      presenter = described_class.new(post)

      expect(presenter.meta_description).to eq("Legacy HTML content here")
    end

    it "returns empty string when no content" do
      post = build(:post, old_content: nil)
      allow(post).to receive(:content).and_return(nil)
      presenter = described_class.new(post)

      expect(presenter.meta_description).to eq("")
    end
  end

    describe "#author" do
    it "returns user email when user is present" do
      user = create(:user, username: "Mr. Blah")
      post = create(:post, user: user)
      presenter = described_class.new(post)

      expect(presenter.author_name).to eq("Mr. Blah")
    end

    it "returns Anonymous when user is not present" do
      post = build(:post, user: nil)
      presenter = described_class.new(post)

      expect(presenter.author_name).to eq("Anonymous")
    end
    end
end
