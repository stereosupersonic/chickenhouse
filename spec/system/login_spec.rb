require "capybara_helper"

describe "Login", type: :system do
  it "as normal user" do
    visit root_path

    expect(page).not_to have_link "Login"

    sign_in create(:user, username: "tim")

    # expect(page).to have_content "Signed in successfully."
    expect(page).not_to have_link "Admin"

    click_link "Ausloggen"
    expect(page).to have_content "Goodbye!"
  end

  it "as a user with a wrong password" do
    visit root_path

    expect(page).not_to have_link "Login"
    user = create(:user, username: "tim")
     user.password = "wrongpassword"
    sign_in user

    expect(page).to have_content "Try another email address or password"
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
