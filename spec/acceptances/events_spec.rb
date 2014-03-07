# -*- coding: UTF-8 -*-
require 'spec_helper'

feature "Events" do

  let(:user) { create :user, :username => "stereosupersonic" }

  scenario "as admin i want to create a new event", :js => true do
    sign_in create(:admin)

    visit admin_root_path

    click_link 'Events'
    click_link 'Neu'
    fill_in 'Titel', :with => "SuperMega Event"
    click_link 'Speichern'
    page.should have_content "Event was successfully created."
    page.should have_content "SuperMega Event"
  end

  scenario "as public user i want to see the last event on top of the page" do
    create :event, :title => "Megasuper event", :user => user

    visit root_path
    within('#next-event') do
      page.should have_content "Megasuper event"
    end
  end

  scenario "as public user i want to see the next 3 events in the sidebar" do
    create :event, :title => "Megasuper event", :user => user
    create :event, :title => "Geiler event", :user => user
    create :event, :title => "Perfekter event", :user => user

    visit root_path
    within('#sidebar') do
      page.should have_content "Megasuper event"
      page.should have_content "Geiler event"
      page.should have_content "Perfekter event"
    end
  end


  scenario "as public user i want to see the all next events under 'Kalender'" do
    create :event, :title => "Megasuper event", :user => user
    create :event, :title => "Geiler event",    :user => user
    create :event, :title => "Perfekter event", :user => user
    create :event, :title => "alter event", :user => user, :start_date => 1.day.ago

    visit root_path
    click_link 'Kalender'
    within('#events_index') do
      page.should have_content "Megasuper event"
      page.should have_content "Geiler event"
      page.should have_content "Perfekter event"
      page.should_not have_content "alter event"
    end
  end

end
