require "rails_helper"

RSpec.describe "Admin::Posts", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  def sign_in(user)
    post "/session", params: { email_address: user.email_address, password: "password123" }
  end

  describe "GET /admin/posts" do
    context "when unauthenticated" do
      it "redirects to login" do
        get "/admin/posts"
        expect(response).to redirect_to(new_session_path)
      end
    end

    context "when non-admin" do
      before { sign_in(user) }

      it "redirects to root" do
        get "/admin/posts"
        expect(response).to redirect_to(root_path)
      end
    end

    context "when admin" do
      before { sign_in(admin) }

      it "returns success" do
        get "/admin/posts"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /admin/posts/new" do
    before { sign_in(admin) }

    it "returns success" do
      get "/admin/posts/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/posts/:id" do
    let!(:existing_post) { create(:post, user: admin) }

    before { sign_in(admin) }

    it "returns success" do
      get "/admin/posts/#{existing_post.slug}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/posts/:id/edit" do
    let!(:existing_post) { create(:post, user: admin) }

    before { sign_in(admin) }

    it "returns success" do
      get "/admin/posts/#{existing_post.slug}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /admin/posts" do
    before { sign_in(admin) }

    context "with valid params" do
      let(:valid_params) { { post: { title: "New Post", content: "Some content" } } }

      it "creates a post" do
        expect {
          post "/admin/posts", params: valid_params
        }.to change(Post, :count).by(1)
      end

      it "redirects to index" do
        post "/admin/posts", params: valid_params
        expect(response).to redirect_to(admin_posts_url)
      end
    end

    context "with invalid params" do
      it "renders new" do
        post "/admin/posts", params: { post: { title: "", content: "" } }
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH /admin/posts/:id" do
    let!(:existing_post) { create(:post, user: admin) }

    before { sign_in(admin) }

    it "updates the post" do
      patch "/admin/posts/#{existing_post.slug}", params: { post: { title: "Updated Title" } }
      expect(response).to redirect_to(admin_posts_url)
      expect(existing_post.reload.title).to eq("Updated Title")
    end
  end

  describe "DELETE /admin/posts/:id" do
    let!(:existing_post) { create(:post, user: admin) }

    before { sign_in(admin) }

    it "destroys the post" do
      expect {
        delete "/admin/posts/#{existing_post.slug}"
      }.to change(Post, :count).by(-1)
    end

    it "redirects to index" do
      delete "/admin/posts/#{existing_post.slug}"
      expect(response).to redirect_to(admin_posts_url)
    end
  end
end
