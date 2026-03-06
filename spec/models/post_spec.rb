# == Schema Information
#
# Table name: posts
#
#  id               :bigint           not null, primary key
#  display_type     :string(255)      default("textile")
#  intern           :boolean          default(FALSE)
#  media            :text
#  old_content      :text
#  old_content_type :string(255)      default("article")
#  slug             :string(255)
#  title            :string(255)      not null
#  visible          :boolean          default(TRUE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#  index_posts_on_visible  (visible)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Post, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user).optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }

    it "is valid with a title" do
      post = build(:post, title: "Test Post")
      expect(post).to be_valid
    end

    it "is invalid without a title" do
      post = build(:post, title: nil)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("muss ausgefüllt werden")
    end

    it "is invalid without a content" do
      post = build(:post, content: nil)
      expect(post).not_to be_valid
      expect(post.errors[:content]).to include("muss ausgefüllt werden")
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
        expect(described_class.current.count).to eq(3)
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
      expect(post.old_content_type).to eq("article")
      expect(post.display_type).to eq("textile")
      expect(post.intern).to be false
      expect(post.visible).to be true
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
