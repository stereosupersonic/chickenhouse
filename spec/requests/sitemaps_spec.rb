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

    it "includes upcoming visible events" do
      upcoming = create(:event, title: "Upcoming Event", start_date: 1.week.from_now)
      past = create(:event, title: "Past Event", start_date: 1.week.ago)

      get sitemap_path(format: :xml)

      expect(response.body).to include(event_url(upcoming))
      expect(response.body).not_to include(event_url(past))
    end

    it "does not require authentication" do
      get sitemap_path(format: :xml)

      expect(response).not_to redirect_to(new_session_path)
    end
  end
end
