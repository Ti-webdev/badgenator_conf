#encoding: utf-8
require 'spec_helper'

describe "Navigation" do

  def check_tab(highlighted)
    [:home, :archive, :contacts].each do |tab|
      if tab == highlighted
        expect(page).to have_selector("ul li.active", :text => I18n::t(tab, scope: "masthead.navigation."))
      else
        expect(page).to_not have_selector("ul li.active", :text => I18n::t(tab, scope: "masthead.navigation."))
      end  
    end
  end

  context "home tab" do
    it "should be highlighted for url /" do
      visit "/"
      check_tab(:home)
    end
  end  

  context "archive tab" do
    it "should be highlighted for url /archive" do
      visit "/archive"
      check_tab(:archive)
    end

    it "should be highlighted for url /archive/page/1" do
      visit "/archive/page/1"
      check_tab(:archive)
    end

    it "should be highlighted for url /archive/:id/badges" do
      badge_set = FactoryGirl.create(:badge_set)
      visit "/archive/#{badge_set.to_param}/badges"
      check_tab(:archive)
    end

    it "should be highlighted for url /archive/:id/badges/page/1" do
      badge_set = FactoryGirl.create(:badge_set)
      visit "/archive/#{badge_set.to_param}/badges/page/1"
      check_tab(:archive)
    end
  end

  context "contacts tab for url /contacts" do
    it "should be highlighted" do
      visit "/contacts"
      check_tab(:contacts)
    end
  end

  context "not found" do
    it "should not be highlighted at all" do
      visit "/not-existed-uri"
      expect(page).to_not have_selector "ul li.active"
    end
  end
end