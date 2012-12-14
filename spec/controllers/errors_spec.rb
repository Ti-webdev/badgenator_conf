#encoding: utf-8
require 'spec_helper'

describe "Errors" do

  context "404" do
    it "should respond with 404 status code" do
      visit "/non-existent"
      page.status_code.should == 404
    end

    it "should content current url" do
      visit "/non-existent"
      page.should have_content('/non-existent')
    end
  end

end