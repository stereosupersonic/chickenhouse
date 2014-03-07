# -*- coding: UTF-8 -*-
require 'spec_helper'

feature "Welcome Page" do

  scenario "see all public menu items" do
    visit root_path

    page.should have_content 'Henaheisl'
    page.should have_link 'Bilder'
    page.should_not have_link 'Kalender'
    page.should_not have_link 'Kontakt'
    page.should have_link 'Über Uns'
    page.shoule have_content 'Alle Rechte vorbehalten'
  end
end
