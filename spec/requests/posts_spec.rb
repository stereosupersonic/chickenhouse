require "rails_helper"

RSpec.describe "Posts", type: :request do
  describe "GET /posts.atom" do
    context "when posts exist" do
      let!(:user) { create(:user, username: "testuser") }
      let!(:post1) { create(:post, title: "First Post", content: "First post content", user: user) }
      let!(:post2) { create(:post, title: "Second Post", content: "Second post content", user: user) }

      before do
        get "/posts.atom"
      end

      it "returns successful response" do
        expect(response).to have_http_status(:success)
      end

      it "returns atom content type" do
        expect(response.content_type).to include("application/atom+xml")
      end

      it "includes XML declaration" do
        expect(response.body).to include('<?xml version="1.0" encoding="UTF-8"?>')
      end

      it "includes atom feed structure" do
        expect(response.body).to include('<feed xml:lang="de-DE" xmlns="http://www.w3.org/2005/Atom">')
        expect(response.body).to include("<title>Henaheisl Blog</title>")
      end

      it "includes feed metadata with proper host and year" do
        expect(response.body).to include("<id>tag:#{request.host},#{Time.zone.now.year}:/posts</id>")
        expect(response.body).to include('rel="alternate"')
        expect(response.body).to include('rel="self"')
        expect(response.body).to include("application/atom+xml")
      end

      it "includes post entries with titles and content" do
        expect(response.body).to include("<title>First Post</title>")
        expect(response.body).to include("<title>Second Post</title>")
        expect(response.body).to include("First post content")
        expect(response.body).to include("Second post content")
      end

      it "includes required entry metadata" do
        expect(response.body).to include("<published>")
        expect(response.body).to include("<updated>")
        expect(response.body).to include('<content type="html">')
        expect(response.body).to include("<author>")
        expect(response.body).to include("<name>")
      end

      it "includes proper entry ids for each post" do
        post1.reload
        post2.reload
        expect(response.body).to include("tag:#{request.host},#{post1.updated_at.year}:Post/#{post1.id}")
        expect(response.body).to include("tag:#{request.host},#{post2.updated_at.year}:Post/#{post2.id}")
      end

      it "includes feed updated timestamp from most recent post" do
        most_recent_post = [ post1, post2 ].max_by(&:updated_at)
        expect(response.body).to include("<updated>#{most_recent_post.updated_at.iso8601}</updated>")
      end

      it "orders posts by creation date descending" do
        body = response.body
        first_post_index = body.index("First Post")
        second_post_index = body.index("Second Post")

        # Posts are ordered by created_at desc, so second post should appear first
        expect(second_post_index).to be < first_post_index
      end
    end

    context "when no posts exist" do
      before do
        get "/posts.atom"
      end

      it "returns successful response" do
        expect(response).to have_http_status(:success)
      end

      it "includes feed structure without entries" do
        expect(response.body).to include("<title>Henaheisl Blog</title>")
        expect(response.body).not_to include("<entry>")
      end

      it "does not include feed updated timestamp when no posts exist" do
        expect(response.body).not_to include("<updated>")
      end
    end

    context "with mix of visible and invisible posts" do
      let!(:user) { create(:user) }
      let!(:visible_post) { create(:post, title: "Visible Post", user: user, visible: true) }
      let!(:invisible_post) { create(:post, title: "Invisible Post", user: user, visible: false) }

      before do
        get "/posts.atom"
      end

      it "only includes visible posts in feed" do
        expect(response.body).to include("Visible Post")
        expect(response.body).not_to include("Invisible Post")
      end
    end

    context "with old_content" do
      let!(:user) { create(:user) }
      let!(:visible_post) { create(:post, title: "Visible Post", old_content: "Old content for visible post", user: user, visible: true) }

      before do
        get "/posts.atom"
      end

      it "only include the  posts in feed" do
        expect(response.body).to include("Old content for visible post")
      end
    end

    context "when using PostPresenter" do
      let!(:user) { create(:user, username: "testauthor") }
      let!(:post) { create(:post, title: "Test Post", content: "Test content", user: user) }

      before do
        get "/posts.atom"
      end

      it "uses PostPresenter for rendering post data" do
        # Verify that presenter methods are being called by checking for formatted output
        expect(response.body).to include("<name>testauthor</name>")
        expect(response.body).to include("Test content")
      end
    end
  end
end
