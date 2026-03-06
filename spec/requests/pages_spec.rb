require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /" do
    it "returns success" do
      get root_path

      expect(response).to have_http_status(:success)
    end

    it "displays current visible posts" do
      user = create(:user)
      create(:post, title: "Recent Post", user: user, visible: true, created_at: 1.day.ago)

      get root_path

      expect(response.body).to include("Recent Post")
    end

    it "does not display old posts" do
      user = create(:user)
      create(:post, title: "Old Post", user: user, visible: true, created_at: 7.months.ago)

      get root_path

      expect(response.body).not_to include("Old Post")
    end

    it "displays the next upcoming event" do
      create(:event, title: "Nächster Stammtisch", start_date: 1.week.from_now)

      get root_path

      expect(response.body).to include("Nächster Stammtisch")
    end

    it "does not require authentication" do
      get root_path

      expect(response).not_to redirect_to(new_session_path)
    end
  end

  describe "GET /bilder" do
    it "returns success" do
      get bilder_path

      expect(response).to have_http_status(:success)
    end

    it "handles subpaths" do
      get "/bilder/some/old/path"

      expect(response).to have_http_status(:success)
    end

    it "returns 404 for non-HTML formats" do
      get "/bilder.json"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /exception" do
    it "raises an error" do
      expect {
        get exception_path
      }.to raise_error(RuntimeError, /test exception/)
    end
  end

  describe "GET /about" do
    it "returns success" do
      get about_path

      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /impressum" do
    it "returns success" do
      get impressum_path

      expect(response).to have_http_status(:success)
    end
  end
end
