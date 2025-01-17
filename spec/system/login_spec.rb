require "capybara_helper"

describe "Login" do
  it "as normal user" do
    visit root_path

    expect(page).not_to have_link "Login"

    sign_in create(:user, username: "tim")

    # expect(page).to have_content "Signed in successfully."
    expect(page).not_to have_link "Admin"

    click_link "Ausloggen"
    expect(page).to have_content "Goodbye!"
  end

  it "as admin user" do
    visit root_path

    expect(page).not_to have_link "Login"

    sign_in create(:admin)
    # expect(page).to have_content "Signed in successfully."
    expect(page).to have_link "Admin"

    click_link "Ausloggen"
    expect(page).to have_content "Goodbye!"
  end
end
