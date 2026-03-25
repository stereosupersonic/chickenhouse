require "capybara_helper"

describe "static pages", type: :system do
  it "about page" do
    visit root_path

    click_link "Über Uns"

    expect(page).to have_content "Der Verein wurde am 20. Juli 1991 als FC Bayern Fanclub Rote Macht Wartenberg"
    expect(page).to have_content "Das Henaheisl"
  end

  describe "bilder page" do
    it "shows data protection notice" do
      visit "/bilder"

      expect(page).to have_content "Bilder / Fotoalben"
      expect(page).to have_content "Datenschutzgründen"
      expect(page).to have_content "info@henaheisl.de"
    end

    it "shows data protection notice for nested album URLs" do
      visit "/bilder/123/456"

      expect(page).to have_content "Bilder / Fotoalben"
      expect(page).to have_content "Datenschutz-Grundverordnung"
    end
  end

  it "contact page" do
    visit root_path

    click_link "Kontakt"

    expect(page).to have_css("h1", text: "Kontakt")
    expect(page).to have_content "Henaheisl e.V."
    expect(page).to have_content "Wartenberg"
    expect(page).to have_link "info@henaheisl.de"
  end

  it "impressum page" do
    visit root_path

    click_link "Impressum"

    expect(page).to have_content "Haftungsausschluss (Disclaimer)"
    expect(page).to have_content "Datenschutzerklärung"
  end
end
