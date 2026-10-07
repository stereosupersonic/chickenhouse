require "capybara_helper"

describe "Flash messages", type: :system do
  it "can be dismissed", :js do
    sign_in create(:user)

    expect(page).to have_content "Welcome back!"

    find("button[aria-label='Schließen']").click

    expect(page).to have_no_content "Welcome back!"
  end
end
