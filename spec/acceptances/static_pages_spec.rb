# -*- coding: UTF-8 -*-
require 'spec_helper'

feature "about page" do

  scenario "about page"do
    visit root_path
    click_link 'Über Uns'
    page.should have_content "Der Verein"
    page.should have_content "Der Verein wurde am 20. Juli 1991 als FC Bayern Fanclub 'Rote Macht Wartenberg'"
    page.should have_content "Das Henaheisl"
    page.should have_content "Das Henaheisl ist wohl einer der bekanntesten \"Underground-Treffs\" in Wartenberg"
  end

   scenario "impressum page" do
    visit root_path
    click_link 'Impressum'
    page.should have_content 'Haftungsausschluss (Disclaimer)'
    page.should have_content 'Datenschutzerklärung'
  end

end

