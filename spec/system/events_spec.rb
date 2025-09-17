require "capybara_helper"

describe "Events", type: :system do
  include ActionView::RecordIdentifier

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
      fill_in "Beschreibung *", with: "SuperMega Event Beschreibung"
      fill_in "Start *", with: "14.11.2024 12:00"
      fill_in "Ende", with: "14.11.2024 14:00"

      click_on "Speichern"

      expect(page).to have_content "Event was successfully created."
      expect(page).to have_content "SuperMega Event"

      click_link "Ändern"
      fill_in "Titel *", with: ""
      click_on "Speichern"
      expect(page).to have_content "Titel muss ausgefüllt werden"

      click_on "Speichern"
      fill_in "Titel *", with: "Cooler Mega Event"

      click_on "Speichern"

      expect(page).to have_content "Cooler Mega Event"

      within("##{dom_id(Event.last)}") do
        click_link "Cooler Mega Event"
      end
      # show page
      within(".event_details") do
        expect(page).to have_content "Cooler Mega Event"
        expect(page).to have_content "SuperMega Event Beschreibung"
        expect(page).to have_content admin.username
      end

      click_link "Zurück"

      within("##{dom_id(Event.last)}") do
        click_link "Löschen"
      end
      expect(page).not_to have_content "Cooler Mega Event"
    end
  end

  context "as public user" do
    it "i can't to see the admin section" do
      visit admin_root_path

      expect(page).not_to have_link "Events"
      expect(page).to have_css "h2", text: "Login"
      expect(page).to have_text "Bitte melden Sie sich an"
    end

    it "i want to see the last event on top of the page" do
      start_date = Time.zone.local(2024, 11, 14, 12, 0, 0)
      create(:event, title: "Megasuper event", location: "Reiter Bräu", start_date: start_date, user: user, all_day: false)
      travel_to start_date do
        visit root_path

        within(".next-event") do
          expect(page).to have_content "Megasuper event"
          expect(page).to have_content "Donnerstag, 14. November 2024, 12:00 Uhr - Reiter Bräu"
        end
      end
    end

    it "i want to see the last event on top of the page when its a whole day" do
      start_date = Time.zone.local(2024, 11, 14, 12, 0, 0)
      create(:event, title: "Megasuper event", location: "Reiter Bräu", start_date: start_date, user: user, all_day: true)
      travel_to start_date do
        visit root_path

        within(".next-event") do
          expect(page).to have_content "Megasuper event"
          expect(page).to have_content "14. November 2024 - Reiter Bräu"
        end
      end
    end

    it "i want to see the next 3 events in the sidebar" do
      event = create(:event, title: "Megasuper event", content: "some blah", user: user, start_date: 1.day.from_now)
      create(:event, title: "Geiler event", user: user, start_date: 2.days.from_now)
      create(:event, title: "Perfekter event", user: user, start_date: 3.days.from_now)

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
