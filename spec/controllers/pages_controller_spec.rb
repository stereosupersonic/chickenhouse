require 'spec_helper'

describe PagesController do
  render_views

  let(:event) { create :event }
  let(:post)  { create :post }

  describe "GET 'welcome'" do

    it "returns http success" do
      get 'welcome'
      response.should be_success
    end

    it "should load the next_event" do
      event
      get 'welcome'
      assigns[:next_event].should ==  event
    end

    it "should load next events" do
      event
      get 'welcome'
      assigns[:next_events].should == [event]
    end

    it "should load only the 3 next events" do
      create :event
      create :event
      create :event
      create :event
      get 'welcome'
      assigns[:next_events].should have(3).items
    end

    it "should load the post" do
      post
      get 'welcome'
      assigns[:posts].should  == [post]
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

end
