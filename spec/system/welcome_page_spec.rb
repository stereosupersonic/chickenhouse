require "capybara_helper"

describe "welcome" do
  it "see all public menu items" do
    visit root_path

    expect(page).to have_title "Henaheisl"
    expect(page).to have_content "Henaheisl"
    expect(page).not_to have_link "Bilder"
    expect(page).to have_link "Kalender"
    expect(page).to have_link "Blog"
    expect(page).not_to have_link "Kontakt"
    expect(page).to have_link "Über Uns"
    expect(page).to have_link "Henaheisl on Facebook"
    expect(page).to have_link "Impressum"
    expect(page).to have_content "Alle Rechte vorbehalten"
  end

  it "shows a logo when no recent posts are available" do
    create :post, created_at: 7.months.ago

    visit root_path

    expect(page).to have_css("img[src*='logo_fcb']")
  end

  it "shows the recent posts but not the log" do
    create :post, title: "title 1"
    create :post, title: "title 3"
    create :post, title: "title 2"

    visit root_path

    expect(page).to have_content "title 1"
    expect(page).to have_content "title 2"
    expect(page).to have_content "title 3"
    expect(page).to_not have_css("img[src*='logo_fcb']")
  end

  it "shows the recent events but none in the past" do
    create :event, title: "event 1"
    create :event, title: "old event", start_date: 1.year.ago

    visit root_path

    expect(page).to have_content "event 1"
    expect(page).to_not have_content "old event"
  end
end
