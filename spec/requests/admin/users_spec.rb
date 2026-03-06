require "rails_helper"

RSpec.describe "Admin::Users", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  def sign_in(user)
    post "/session", params: { email_address: user.email_address, password: "password123" }
  end

  describe "GET /admin/users" do
    context "when unauthenticated" do
      it "redirects to login" do
        get "/admin/users"
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when non-admin" do
      before { sign_in(user) }

      it "redirects to root" do
        get "/admin/users"
        expect(response).to redirect_to(root_path)
      end
    end

    context "when admin" do
      before { sign_in(admin) }

      it "returns success" do
        get "/admin/users"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST /admin/users" do
    before { sign_in(admin) }

    context "with valid params" do
      let(:valid_params) do
        {
          user: {
            username: "newuser",
            email_address: "new@example.com",
            password: "password123",
            password_confirmation: "password123"
          }
        }
      end

      it "creates a user" do
        expect {
          post "/admin/users", params: valid_params
        }.to change(User, :count).by(1)
      end

      it "redirects to index" do
        post "/admin/users", params: valid_params
        expect(response).to redirect_to(admin_users_url)
      end
    end

    context "with invalid params" do
      it "renders new" do
        post "/admin/users", params: { user: { username: "", email_address: "" } }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH /admin/users/:id" do
    let!(:target_user) { create(:user) }

    before { sign_in(admin) }

    it "updates the user" do
      patch "/admin/users/#{target_user.id}", params: { user: { username: "updatedname" } }
      expect(response).to redirect_to(admin_users_url)
      expect(target_user.reload.username).to eq("updatedname")
    end
  end

  describe "DELETE /admin/users/:id" do
    let!(:target_user) { create(:user) }

    before { sign_in(admin) }

    it "destroys the user" do
      expect {
        delete "/admin/users/#{target_user.id}"
      }.to change(User, :count).by(-1)
    end

    it "prevents admin from deleting themselves" do
      delete "/admin/users/#{admin.id}"
      expect(response).to redirect_to(admin_users_url)
      expect(User.exists?(admin.id)).to be true
    end
  end
end
