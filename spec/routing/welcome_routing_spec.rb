require "spec_helper"

describe WelcomeController do
  describe "routing" do

    it "routes to #index" do
      get("/").should route_to("welcome#index")
    end

    it "routes to #contacts" do
      get("/contacts").should route_to("welcome#contacts")
    end

  end
end