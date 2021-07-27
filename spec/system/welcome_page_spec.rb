require "capybara_helper"

describe "welcome", type: :system do
  it "see all public menu items" do
    visit root_path

    expect(page).to have_title "Henaheisl"
    expect(page).to have_content "Henaheisl"
    expect(page).not_to have_link "Bilder"
    expect(page).to have_link "Kalender"
    expect(page).not_to have_link "Kontakt"
    expect(page).to have_link "Über Uns"
    expect(page).to have_link "Henaheisl on Facebook"
    expect(page).to have_link "Impressum"
    expect(page).to have_content "Alle Rechte vorbehalten"
  end
end
