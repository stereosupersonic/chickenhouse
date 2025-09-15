# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  attachment_content_type :string
#  attachment_file_name    :string
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  content                 :text
#  content_type            :string           default("article")
#  display_type            :string           default("textile")
#  intern                  :boolean          default(FALSE)
#  media                   :text
#  media_type              :string
#  out_of_date             :datetime
#  slug                    :string
#  title                   :string
#  twitter_export          :boolean          default(TRUE)
#  visible                 :boolean          default(TRUE)
#  created_at              :datetime
#  updated_at              :datetime
#  album_id                :integer
#  user_id                 :integer
#
# Indexes
#
#  index_posts_on_album_id  (album_id)
#  index_posts_on_intern    (intern)
#  index_posts_on_visible   (visible)
#

require "rails_helper"

RSpec.describe Post, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user).optional }
    # it { should belong_to(:album).optional } # Album model doesn't exist
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }

    it "is valid with a title" do
      post = build(:post, title: "Test Post")
      expect(post).to be_valid
    end

    it "is invalid without a title" do
      post = build(:post, title: nil)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("muss ausgefüllt werden")
    end

    it "is invalid with empty title" do
      post = build(:post, title: "")
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("muss ausgefüllt werden")
    end
  end

  describe "scopes" do
    let(:user) { create(:user) }

    before do
      create(:post, visible: true, user: user, title: "Visible Post")
      create(:post, visible: false, user: user, title: "Hidden Post")
      create(:post, visible: true, created_at: 1.year.ago, user: user, title: "Old Post")
      create(:post, visible: true, created_at: 1.month.ago, user: user, title: "Recent Post")
    end

    describe ".visible" do
      it "returns only visible posts" do
        expect(described_class.visible.count).to eq(3)
        expect(described_class.visible.pluck(:title)).to include("Visible Post", "Old Post", "Recent Post")
        expect(described_class.visible.pluck(:title)).not_to include("Hidden Post")
      end
    end

    describe ".current" do
      it "returns posts created within the last 6 months" do
        expect(described_class.current.count).to eq(3) # 2 recent + 1 hidden but recent
        expect(described_class.current.pluck(:title)).to include("Visible Post", "Hidden Post", "Recent Post")
        expect(described_class.current.pluck(:title)).not_to include("Old Post")
      end
    end
  end

  describe "friendly_id" do
    it "generates slug from title" do
      post = create(:post, title: "My Awesome Post")
      expect(post.slug).to eq("my-awesome-post")
    end

    it "handles duplicate titles" do
      user = create(:user)
      create(:post, title: "Duplicate Title", user: user)
      post2 = create(:post, title: "Duplicate Title", user: user)
      expect(post2.slug).to start_with("duplicate-title-")
    end

    it "can be found by slug" do
      post = create(:post, title: "Findable Post")
      found_post = described_class.friendly.find(post.slug)
      expect(found_post).to eq(post)
    end

    it "has a friendly title" do
      post = create(:post, title: "How cool is that")
      expect(post.to_param).to eq("how-cool-is-that")
    end
  end

  describe "default values" do
    it "sets default values correctly" do
      post = described_class.new
      expect(post.content_type).to eq("article")
      expect(post.display_type).to eq("textile")
      expect(post.intern).to be false
      expect(post.twitter_export).to be true
      expect(post.visible).to be true
    end
  end

  describe "#html_content" do
    context "when display_type is raw" do
      it "returns content as html_safe" do
        post = create(:post, content: "<p>Raw HTML</p>", display_type: "raw")
        html_content = post.html_content
        expect(html_content).to eq("<p>Raw HTML</p>")
        expect(html_content).to be_html_safe
      end
    end

    context "when display_type is not raw" do
      it "returns content as html_safe" do
        post = create(:post, content: "Regular content", display_type: "textile")
        html_content = post.html_content
        expect(html_content).to eq("Regular content")
        expect(html_content).to be_html_safe
      end
    end

    it "handles nil content" do
      post = build(:post, content: "")
      expect(post.html_content).to be_html_safe
    end
  end

  describe "#author" do
    it "returns user email when user is present" do
      user = create(:user, email_address: "author@example.com")
      post = create(:post, user: user)
      expect(post.author).to eq("author@example.com")
    end

    it "returns Anonymous when user is not present" do
      post = build(:post, user: nil)
      expect(post.author).to eq("Anonymous")
    end
  end

  describe "attachment attributes" do
    it "can store attachment metadata" do
      post = create(:post,
                    attachment_file_name:    "test.jpg",
                    attachment_content_type: "image/jpeg",
                    attachment_file_size:    1024,
                    attachment_updated_at:   Time.current)

      expect(post.attachment_file_name).to eq("test.jpg")
      expect(post.attachment_content_type).to eq("image/jpeg")
      expect(post.attachment_file_size).to eq(1024)
      expect(post.attachment_updated_at).to be_present
    end
  end

  describe "media attributes" do
    it "can store media content and type" do
      media_content = "Video embed code"
      post = create(:post, media: media_content, media_type: "video")

      expect(post.media).to eq(media_content)
      expect(post.media_type).to eq("video")
    end
  end

  describe "factory" do
    it "creates a valid factory" do
      expect(build(:post)).to be_valid
    end

    it "creates a post with associated user" do
      post = create(:post)
      expect(post.user).to be_present
      expect(post.user).to be_a(User)
    end
  end
end
