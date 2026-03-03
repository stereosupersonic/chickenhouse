require "capybara_helper"

describe "Posts", type: :system do
  include ActionView::RecordIdentifier

  let(:user)  { create(:user, username: "stereosupersonic") }
  let(:admin) { create(:admin) }

  context "as admin" do
    before { sign_in admin }

    it "as admin i want to manage posts" do
      visit root_path
      expect(page).to have_content "Blog"

      visit admin_root_path

      click_link "Posts"
      click_link "Neu"

      click_on "Speichern"

      expect(page).to have_content "Bitte überprüfen sie nachfolgende Probleme:"
      expect(page).to have_content "Titel muss ausgefüllt werden"

      fill_in "Titel *", with: "Coole Mega Fugge"
      find("#post_content_trix_input_post", visible: false).set("Mega Beitrag")

      # fill_in_rich_text_area doesnt work with docker tests
      # fill_in_rich_text_area "Content", with: "Mega Beitrag"
      click_on "Speichern"

      expect(page).to have_content "Post was successfully created."
      expect(page).to have_content "Coole Mega Fugge"

      click_link "Ändern"
      fill_in "Titel *", with: ""
      click_on "Speichern"

      expect(page).to have_content "Titel muss ausgefüllt werden"
      fill_in "Titel *", with: "Coole Mega fucke"

      click_on "Speichern"

      expect(page).to have_content "Post was successfully updated."
      expect(page).to have_content "Coole Mega fucke"

      within("##{dom_id(Post.last)}") do
        click_link "Coole Mega fucke"
      end
      # show page
      expect(page).to have_content "Coole Mega fucke"
      expect(page).to have_content "Mega Beitrag"

      click_link "Zurück"

      click_link "Löschen"

      expect(page).not_to have_content "Coole Mega fucke"
    end
  end

  context "search" do
    it "finds posts by search query" do
      create(:post, title: "Sommerfest 2026", content: "Ein tolles Fest", user: user)
      create(:post, title: "Winterpause", content: "Nichts los", user: user)

      visit posts_path(q: "Sommerfest")

      expect(page).to have_content "Sommerfest 2026"
      expect(page).not_to have_content "Winterpause"
      expect(page).to have_content "Suchergebnisse für:"
    end

    it "clears the search" do
      create(:post, title: "Sommerfest 2026", content: "Ein tolles Fest", user: user)
      create(:post, title: "Winterpause", content: "Nichts los", user: user)

      visit posts_path(q: "Sommerfest")

      expect(page).to have_content "Sommerfest 2026"
      expect(page).not_to have_content "Winterpause"

      click_link "Suche zurücksetzen"

      expect(page).to have_content "Sommerfest 2026"
      expect(page).to have_content "Winterpause"
      expect(page).not_to have_content "Suchergebnisse für:"
    end

    it "shows search form in navigation" do
      visit posts_path

      expect(page).to have_css "i.fa-solid.fa-magnifying-glass"
      expect(page).to have_field "q"
    end
  end

  context "as public user" do
    it "as public user i want to see the Post" do
      create(:post,
             title:   "Coole Mega Fugge",
             old_content: "der Lorem Ipsum of the Posts",
             user:    user)

      visit root_path

      within("#posts") do
        expect(page).to have_content "Coole Mega Fugge"
        expect(page).to have_content "der Lorem Ipsum of the Posts"
      end

      click_link "Coole Mega Fugge"
      within("#posts_show") do
        expect(page).to have_content "Coole Mega Fugge"
        expect(page).to have_content "der Lorem Ipsum of the Posts"
      end

      visit root_path
      click_link "Blog"
      within("#posts") do
        expect(page).to have_content "Coole Mega Fugge"
        expect(page).to have_content "der Lorem Ipsum of the Posts"
      end
    end
  end
end
