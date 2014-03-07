# -*- coding: UTF-8 -*-
require 'spec_helper'

feature "Login" do

  scenario "as normal user" do
    visit root_path
    page.should have_link 'Login'
    sign_in create(:user, :username => 'tim')
    page.should have_content "Signed in successfully."
    page.should_not have_link 'Admin'
    click_link 'Ausloggen'
    page.should have_content "Signed out."
  end

  scenario "as admin user" do
    visit root_path
    page.should have_link 'Login'
    sign_in create(:admin)
    page.should have_content "Signed in successfully."
    page.should have_link 'Admin'
    click_link 'Ausloggen'
    page.should have_content "Signed out."
  end
end
