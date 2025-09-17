require "capybara_helper"

describe "Users", type: :system do
  include ActionView::RecordIdentifier

  let(:admin) { create(:admin) }

  context "as admin" do
    it "i want to manage a new users" do
      sign_in admin

      visit admin_root_path

      click_link "Users"
      click_link "Neu"

      click_on "Speichern"

      expect(page).to have_content "Bitte überprüfen sie nachfolgende Probleme:"
      expect(page).to have_content "Username muss ausgefüllt werden"

      fill_in "Name *", with: "Supa Dupa"
      fill_in "E-Mail *", with: "supa@dupa.com"
      fill_in "Passwort", with: "password123"
      fill_in "Passwort wiederholen", with: "password123"

      click_on "Speichern"

      expect(page).to have_content "User was successfully created."
      expect(page).to have_content "Supa Dupa"
      within "##{dom_id(User.last)}" do
        expect(page).to have_content "Supa Dupa"
        click_link "Ändern"
      end
      fill_in "Name *", with: ""
      click_on "Speichern"
      expect(page).to have_content "Username muss ausgefüllt werden"

      click_on "Speichern"
      fill_in "Name *", with: "Coole Mega fucker"

      click_on "Speichern"

      expect(page).to have_content "Coole Mega fucker"

      within "##{dom_id(User.last)}" do
        click_link "Löschen"
      end

      expect(page).not_to have_content "Coole Mega fucker"

      within "##{dom_id(admin)}" do
        click_link "Löschen"
      end

      expect(page).to have_content "Sich selbst kann man nicht löschen"
    end
  end
end
