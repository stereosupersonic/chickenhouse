require "capybara_helper"

describe "Posts", type: :system do
  let(:user) { create(:user, username: "stereosupersonic") }

  it "as admin i want to manage posts", js: true do
    visit root_path
    expect(page).to have_content "Blog"
    admin = create(:admin)
    sign_in admin

    visit admin_root_path

    click_link "Posts"
    click_link "Neu"
    fill_in "Titel *", with: "Coole Mega Fugge"
    click_on "Speichern"
    expect(page).to have_content "Coole Mega Fugge"

    click_link "Ändern"
    fill_in "Titel *", with: "Coole Mega fucke"

    click_on "Speichern"

    expect(page).to have_content "Coole Mega fucke"

    click_link "Löschen"
    # accept modal confirm dialog
    page.driver.browser.switch_to.alert.accept

    expect(page).not_to have_content "Coole Mega fucke"
  end

  it "as public user i want to see the Post" do
    create(:post,
           title:      "Coole Mega Fugge",
           content:    "der Lorem Ipsum of the Posts",
           user: user)

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
  end
end
