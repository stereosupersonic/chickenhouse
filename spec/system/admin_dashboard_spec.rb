require "capybara_helper"

describe "Admin Dashboard", type: :system do
  let(:admin) { create(:admin) }

  context "as admin" do
    before { sign_in admin }

    it "shows the dashboard with resource counts and links" do
      create_list(:post, 3)
      create_list(:event, 2)

      visit admin_root_path

      expect(page).to have_link "Posts"
      expect(page).to have_link "Events"
      expect(page).to have_link "Users"

      expect(page).to have_content "3"
      expect(page).to have_content "2"
    end

    it "shows deploy and version info" do
      visit admin_root_path

      expect(page).to have_content "Debug"
      expect(page).to have_content "Rails Version"
      expect(page).to have_content Rails.version
    end
  end
end
