require "rails_helper"

RSpec.describe "Events", type: :request do
  describe "GET /events" do
    it "returns success" do
      get events_path

      expect(response).to have_http_status(:success)
    end

    it "displays visible future events" do
      create(:event, title: "Stammtisch", start_date: 1.week.from_now, visible: true)

      get events_path

      expect(response.body).to include("Stammtisch")
    end

    it "does not display past events" do
      create(:event, title: "Past Event", start_date: 1.week.ago)

      get events_path

      expect(response.body).not_to include("Past Event")
    end

    it "does not require authentication" do
      get events_path

      expect(response).not_to redirect_to(new_session_path)
    end
  end

  describe "GET /events/:id" do
    it "returns success" do
      event = create(:event, title: "Stammtisch")

      get event_path(event)

      expect(response).to have_http_status(:success)
    end

    it "displays the event details" do
      event = create(:event, title: "Sommerfest", content: "Alle sind eingeladen")

      get event_path(event)

      expect(response.body).to include("Sommerfest")
      expect(response.body).to include("Alle sind eingeladen")
    end

    it "adds noindex tag for past events" do
      event = create(:event, start_date: 1.day.ago)

      get event_path(event)

      expect(response.body).to include('name="robots"')
      expect(response.body).to include("noindex")
    end

    it "does not add noindex tag for future events" do
      event = create(:event, start_date: 1.day.from_now)

      get event_path(event)

      expect(response.body).not_to include("noindex")
    end

    it "does not require authentication" do
      event = create(:event)

      get event_path(event)

      expect(response).not_to redirect_to(new_session_path)
    end
  end
end
