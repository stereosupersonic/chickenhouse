# require 'capybara_helper'

# describe "Contact" do

#   it "as public user i want to sent a mail", :js => true do

#     visit admin_root_path

#     click_link 'Kontakt'
#     fill_in 'Name', :with => "Mr Mega cool"
#     fill_in 'EMail', :with => "mega@cool.de"
#     fill_in 'Betreff', :with => "hab da mal ne frache"
#     fill_in 'Nachticht', :with => "wie viele von euch"
#     click_link 'Absenden'
#     page.should have_content "Nachricht wurde erfolgreich gesendet"
#   end

#   scenario "as admin i want to see all contacts" do
#     sign_in create(:admin )
#     create(:contact, :subject => 'Hallo Welt', :body => "some test body")
#     visit admin_root_path

#     click_link 'Nachrichten'
#     click_link 'Hallo Welt'
#     page.should have_content "Hallo Welt"
#     page.shouldhave_content  "some test body"
#   end
# end
