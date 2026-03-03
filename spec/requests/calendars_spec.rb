require "rails_helper"

RSpec.describe "Calendars", type: :request do
  describe "GET /calendar" do
    it "returns a successful response with text/calendar content type" do
      get calendar_path

      expect(response).to have_http_status(:ok)
      expect(response.headers["Content-Type"]).to include("text/calendar")
    end

    it "returns valid ICS with calendar name" do
      get calendar_path

      expect(response.body).to include("BEGIN:VCALENDAR")
      expect(response.body).to include("END:VCALENDAR")
      expect(response.body).to include("X-WR-CALNAME:Henaheisl e.V. - Kalender")
    end

    it "includes visible upcoming events" do
      event = create(:event, title: "Stammtisch", start_date: 1.week.from_now, visible: true)

      get calendar_path

      expect(response.body).to include("BEGIN:VEVENT")
      expect(response.body).to include("SUMMARY:Stammtisch")
      expect(response.body).to include("UID:event-#{event.id}@")
    end

    it "excludes non-visible events" do
      create(:event, title: "Hidden Event", start_date: 1.week.from_now, visible: false)

      get calendar_path

      expect(response.body).not_to include("Hidden Event")
    end

    it "excludes past events" do
      create(:event, title: "Past Event", start_date: 1.week.ago)

      get calendar_path

      expect(response.body).not_to include("Past Event")
    end

    it "handles all-day events with DATE values" do
      create(:event, title: "Ganztags Event", start_date: 1.week.from_now, all_day: true)

      get calendar_path

      expect(response.body).to include("SUMMARY:Ganztags Event")
      expect(response.body).not_to include("DTSTART;TZID")
    end

    it "includes location when present" do
      create(:event, title: "Mit Ort", start_date: 1.week.from_now, location: "Wartenberg")

      get calendar_path

      expect(response.body).to include("LOCATION:Wartenberg")
    end

    it "does not require authentication" do
      get calendar_path

      expect(response).not_to have_http_status(:unauthorized)
      expect(response).not_to redirect_to(new_session_path)
    end
  end
end
