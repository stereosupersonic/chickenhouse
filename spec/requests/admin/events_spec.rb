require "rails_helper"

RSpec.describe "Admin::Events", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  def sign_in(user)
    post "/session", params: { email_address: user.email_address, password: "password123" }
  end

  describe "GET /admin/events" do
    context "when unauthenticated" do
      it "redirects to login" do
        get "/admin/events"
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when non-admin" do
      before { sign_in(user) }

      it "redirects to root" do
        get "/admin/events"
        expect(response).to redirect_to(root_path)
      end
    end

    context "when admin" do
      before { sign_in(admin) }

      it "returns success" do
        get "/admin/events"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /admin/events/new" do
    before { sign_in(admin) }

    it "returns success" do
      get "/admin/events/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/events/:id" do
    let!(:event) { create(:event, user: admin) }

    before { sign_in(admin) }

    it "returns success" do
      get "/admin/events/#{event.slug}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/events/:id/edit" do
    let!(:event) { create(:event, user: admin) }

    before { sign_in(admin) }

    it "returns success" do
      get "/admin/events/#{event.slug}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /admin/events" do
    before { sign_in(admin) }

    context "with valid params" do
      let(:valid_params) do
        {
          event: {
            title: "Stammtisch",
            content: "Monatlicher Stammtisch",
            location: "Wartenberg",
            start_date: 1.week.from_now,
            all_day: false,
            visible: true
          }
        }
      end

      it "creates an event" do
        expect {
          post "/admin/events", params: valid_params
        }.to change(Event, :count).by(1)
      end

      it "redirects to index" do
        post "/admin/events", params: valid_params
        expect(response).to redirect_to(admin_events_url)
      end
    end

    context "with invalid params" do
      it "renders new" do
        post "/admin/events", params: { event: { title: "", content: "" } }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH /admin/events/:id" do
    let!(:event) { create(:event, user: admin) }

    before { sign_in(admin) }

    it "updates the event" do
      patch "/admin/events/#{event.slug}", params: { event: { title: "Updated Event" } }
      expect(response).to redirect_to(admin_events_url)
      expect(event.reload.title).to eq("Updated Event")
    end
  end

  describe "DELETE /admin/events/:id" do
    let!(:event) { create(:event, user: admin) }

    before { sign_in(admin) }

    it "destroys the event" do
      expect {
        delete "/admin/events/#{event.slug}"
      }.to change(Event, :count).by(-1)
    end

    it "redirects to index" do
      delete "/admin/events/#{event.slug}"
      expect(response).to redirect_to(admin_events_url)
    end
  end
end
