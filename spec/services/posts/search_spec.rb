require "rails_helper"

RSpec.describe Posts::Search do
  let(:user) { create(:user) }

  describe "#call" do
    it "finds posts by title" do
      post = create(:post, title: "Sommerfest 2026", user: user)
      create(:post, title: "Winterpause", user: user)

      result = described_class.call(query: "Sommerfest", scope: Post.all)

      expect(result).to include(post)
      expect(result.count).to eq(1)
    end

    it "finds posts by rich text content" do
      post = create(:post, title: "Einladung", content: "Kommt zum großen Hühnerfest", user: user)
      create(:post, title: "Anderer Beitrag", content: "Nichts besonderes", user: user)

      result = described_class.call(query: "Hühnerfest", scope: Post.all)

      expect(result).to include(post)
      expect(result.count).to eq(1)
    end

    it "is case insensitive" do
      post = create(:post, title: "GROSSES FEST", user: user)

      expect(described_class.call(query: "grosses", scope: Post.all)).to include(post)
      expect(described_class.call(query: "GROSSES", scope: Post.all)).to include(post)
    end

    it "returns no duplicates when query matches both title and content" do
      post = create(:post, title: "Hühnerfest", content: "Das große Hühnerfest", user: user)

      result = described_class.call(query: "Hühnerfest", scope: Post.all)

      expect(result.count).to eq(1)
      expect(result).to include(post)
    end

    it "returns empty relation when nothing matches" do
      create(:post, title: "Sommerfest", user: user)

      expect(described_class.call(query: "Weihnachten", scope: Post.all)).to be_empty
    end

    it "supports German stemming" do
      post = create(:post, title: "Einladungen zum Fest", user: user)

      expect(described_class.call(query: "Einladung", scope: Post.all)).to include(post)
    end

    it "ranks title matches higher than body-only matches" do
      body_match = create(:post, title: "Anderer Beitrag", content: "Sommerfest im Garten", user: user)
      title_match = create(:post, title: "Sommerfest 2026", content: "Allgemeine Informationen", user: user)

      result = described_class.call(query: "Sommerfest", scope: Post.all)

      expect(result).to eq([ title_match, body_match ])
    end

    it "ranks by relevance even when the scope is already ordered" do
      title_match = create(:post, title: "Sommerfest 2026", content: "Allgemeine Informationen", created_at: 2.days.ago, user: user)
      body_match = create(:post, title: "Anderer Beitrag", content: "Sommerfest im Garten", created_at: 1.day.ago, user: user)

      result = described_class.call(query: "Sommerfest", scope: Post.order(created_at: :desc))

      expect(result).to eq([ title_match, body_match ])
    end

    it "searches within given scope" do
      visible_post = create(:post, title: "Sommerfest", visible: true, user: user)
      create(:post, title: "Sommerfest intern", visible: false, user: user)

      result = described_class.call(query: "Sommerfest", scope: Post.visible)

      expect(result).to include(visible_post)
      expect(result.count).to eq(1)
    end
  end
end
