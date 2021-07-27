require "capybara_helper"

describe "Posts", type: :system, js: true do
  let(:user) { create :user, username: "stereosupersonic" }

  it "as admin i want to manage posts", js: true do
    sign_in create(:admin)

    visit admin_root_path

    click_link "Posts"
    click_link "Neu"
    fill_in " Title", with: "Coole Mega Fugge"
    click_link "Speichern"
    page.should have_content "Coole Mega Fugge"

    click_link "Ändern"
    fill_in " Title", with: "Coole Mega fucke"
    click_link "Speichern"
    page.should have_content "Coole Mega fucke"

    click_link "Löschen"
    # accept modal confirm dialog
    page.driver.browser.switch_to.alert.accept

    page.should_not have_content "Coole Mega fucke"
  end

  it "as public user i want to see the Post" do
    create :post,
      title: "Coole Mega Fugge",
      content: "der Lorem Ipsum of the Posts",
      user: user,
      attachment: File.new(Rails.root + "spec/fixtures/cooler_upload.pdf")

    visit root_path
    within("#posts") do
      page.should have_content "Coole Mega Fugge"
      page.should have_content "der Lorem Ipsum of the Posts"
      page.should have_link "cooler_upload.pdf"
    end

    click_link "Coole Mega Fugge"
    within("#posts_show") do
      page.should have_content "Coole Mega Fugge"
      page.should have_content "der Lorem Ipsum of the Posts"
    end
  end
end
