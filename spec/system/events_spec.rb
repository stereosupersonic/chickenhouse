require "capybara_helper"

describe "Events", type: :system do
  let(:user)  { create(:user, username: "stereosupersonic") }
  let(:admin) { create(:admin) }

  context "as admin" do
    it "i want to manage a new event" do
      sign_in admin

      visit admin_root_path

      click_link "Events"
      click_link "Neu"

      click_on "Speichern"

      expect(page).to have_content "Bitte überprüfen sie nachfolgende Probleme:"
      expect(page).to have_content "Titel muss ausgefüllt werden"

      fill_in "Titel *", with: "SuperMega Event"
      fill_in "Beschreibung *", with: "SuperMega Event"

      click_on "Speichern"

      expect(page).to have_content "Event was successfully created."
      expect(page).to have_content "SuperMega Event"

      click_link "Ändern"
      fill_in "Titel *", with: ""
      click_on "Speichern"
      expect(page).to have_content "Titel muss ausgefüllt werden"

      click_on "Speichern"
      fill_in "Titel *", with: "Coole Mega fucke"

      click_on "Speichern"

      expect(page).to have_content "Coole Mega fucke"

      click_link "Löschen"
      expect(page).not_to have_content "Coole Mega fucke"
    end
  end

  context "as public user" do
    it "i can't to see the admin section" do
      visit admin_root_path

      expect(page).to_not have_link "Events"
      expect(page).to have_css "h2", text: "Login"
      expect(page).to have_text "Bitte melden Sie sich an"
    end

    it "i want to see the last event on top of the page" do
      create(:event, title: "Megasuper event", user: user)

      visit root_path

      within(".next-event") do
        expect(page).to have_content "Megasuper event"
      end
    end

    it "i want to see the next 3 events in the sidebar" do
      event = create(:event, title: "Megasuper event", content: "some blah", user: user)
      create(:event, title: "Geiler event", user: user)
      create(:event, title: "Perfekter event", user: user)

      visit root_path

      within("#sidebar") do
        expect(page).to have_content "Megasuper event"
        expect(page).to have_content "Geiler event"
        expect(page).to have_content "Perfekter event"
      end

      within(".sidebar-event.event-#{event.id}") do
        click_on "Megasuper event"
      end

      expect(page).to have_content "Megasuper event"
      expect(page).to have_content "some blah"
    end

    it "i want to see the all next events under 'Kalender'" do
      create(:event, title: "Megasuper event", user: user, start_date: 1.day.from_now)
      create(:event, title: "Geiler event", user: user, start_date: Time.zone.today)
      create(:event, title: "Perfekter event", user: user, start_date: 2.days.from_now)
      create(:event, title: "alter event", user: user, start_date: 1.day.ago)

      visit root_path

      click_link "Kalender"

      within("#events_index") do
        expect(page).to have_content "Megasuper event"
        expect(page).to have_content "Geiler event"
        expect(page).to have_content "Perfekter event"
        expect(page).not_to have_content "alter event"
      end
    end
  end
end
