require "capybara_helper"

describe "static pages", type: :system do
  it "about page" do
    visit root_path

    click_link "Über Uns"

    expect(page).to have_content "Der Verein wurde am 20. Juli 1991 als FC Bayern Fanclub Rote Macht Wartenberg"
    expect(page).to have_content "Das Henaheisl"
  end

  it "impressum page" do
    visit root_path

    click_link "Impressum"

    expect(page).to have_content "Haftungsausschluss (Disclaimer)"
    expect(page).to have_content "Datenschutzerklärung"
  end
end
