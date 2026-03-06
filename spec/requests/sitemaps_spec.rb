require "rails_helper"

RSpec.describe "Sitemaps", type: :request do
  describe "GET /sitemap.xml" do
    it "returns success with XML content type" do
      get sitemap_path(format: :xml)

      expect(response).to have_http_status(:success)
      expect(response.content_type).to include("application/xml")
    end

    it "includes posts" do
      user = create(:user)
      post = create(:post, title: "Sitemap Post", user: user)

      get sitemap_path(format: :xml)

      expect(response.body).to include(post_url(post))
    end

    it "includes events" do
      event = create(:event, title: "Sitemap Event")

      get sitemap_path(format: :xml)

      expect(response.body).to include(event_url(event))
    end

    it "does not require authentication" do
      get sitemap_path(format: :xml)

      expect(response).not_to redirect_to(new_session_path)
    end
  end
end
