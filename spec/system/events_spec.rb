require "capybara_helper"

describe "Events", type: :system, js: true do
  let(:user) { create :user, username: "stereosupersonic" }
  let(:admin) { create :admin }

  scenario "as admin i want to create a new event" do
    sign_in admin

    visit admin_root_path

    click_link "Events"
    click_link "Neu"

    fill_in " Title", with: "SuperMega Event"

    click_link "Speichern"

    expect(page).to have_content "Event was successfully created."
    expect(page).to have_content "SuperMega Event"
  end

  scenario "as public user i want to see the last event on top of the page" do
    create :event, title: "Megasuper event", user: user

    visit root_path
    within("#next-event") do
      expect(page).to have_content "Megasuper event"
    end
  end

  scenario "as public user i want to see the next 3 events in the sidebar" do
    create :event, title: "Megasuper event", user: user
    create :event, title: "Geiler event", user: user
    create :event, title: "Perfekter event", user: user

    visit root_path
    within("#sidebar") do
      expect(page).to have_content "Megasuper event"
      expect(page).to have_content "Geiler event"
      expect(page).to have_content "Perfekter event"
    end
  end

  scenario "as public user i want to see the all next events under 'Kalender'" do
    create :event, title: "Megasuper event", user: user
    create :event, title: "Geiler event", user: user
    create :event, title: "Perfekter event", user: user
    create :event, title: "alter event", user: user, start_date: 1.day.ago

    visit root_path

    click_link "Kalender"

    within("#events_index") do
      expect(page).to have_content "Megasuper event"
      expect(page).to have_content "Geiler event"
      expect(page).to have_content "Perfekter event"
      expect(page).to_not have_content "alter event"
    end
  end
end
