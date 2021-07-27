require "capybara_helper"

describe "Login", type: :system do
  xit "as normal user" do
    visit root_path

    expect(page).to_not have_link "Login"

    sign_in create(:user, username: "tim")

    expect(page).to have_content "Signed in successfully."
    expect(page).to_not have_link "Admin"

    click_link "Ausloggen"
    expect(page).to have_content "Signed out."
  end

  it "as admin user" do
    visit root_path

    expect(page).to_not have_link "Login"

    sign_in create(:admin)
    expect(page).to have_content "Signed in successfully."
    expect(page).to have_link "Admin"

    click_link "Ausloggen"
    expect(page).to have_content "Signed out."
  end
end
