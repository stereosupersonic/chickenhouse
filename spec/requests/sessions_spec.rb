require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "GET /session/new" do
    it "returns success" do
      get new_session_path

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /session" do
    let!(:user) { create(:user, email_address: "test@example.com", password: "password123") }

    context "with valid credentials" do
      it "redirects to root" do
        post session_path, params: { email_address: "test@example.com", password: "password123" }

        expect(response).to redirect_to(root_url)
      end

      it "creates a session record" do
        expect {
          post session_path, params: { email_address: "test@example.com", password: "password123" }
        }.to change(Session, :count).by(1)
      end

      it "sets session cookie" do
        post session_path, params: { email_address: "test@example.com", password: "password123" }

        expect(cookies[:session_id]).to be_present
      end
    end

    context "with invalid credentials" do
      it "redirects to login with alert" do
        post session_path, params: { email_address: "test@example.com", password: "wrong" }

        expect(response).to redirect_to(new_session_path)
        expect(flash[:alert]).to be_present
      end

      it "does not create a session record" do
        expect {
          post session_path, params: { email_address: "test@example.com", password: "wrong" }
        }.not_to change(Session, :count)
      end
    end
  end

  describe "DELETE /session" do
    let!(:user) { create(:user) }

    before do
      post session_path, params: { email_address: user.email_address, password: "password123" }
    end

    it "destroys the session and redirects" do
      expect {
        delete session_path
      }.to change(Session, :count).by(-1)

      expect(response).to redirect_to(root_url)
    end
  end
end
