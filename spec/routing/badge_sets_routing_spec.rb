require "spec_helper"

describe BadgeSetsController do
  describe "routing" do

    it "routes to #index" do
      get("/archive").should route_to("badge_sets#index")
    end

    it "routes to #index with page" do
      get("/archive/page/2").should route_to("badge_sets#index", :page => "2")
    end

    # it "does not expose a badge set" do
    #   expect(:get => "/archive/1").not_to be_routable
    # end

    it "routes to #new" do
      get("/archive/new").should route_to("badge_sets#new")
    end

    it "routes to #edit" do
      get("/archive/1/edit").should route_to("badge_sets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/archive").should route_to("badge_sets#create")
    end

    it "routes to #update" do
      put("/archive/1").should route_to("badge_sets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/archive/1").should route_to("badge_sets#destroy", :id => "1")
    end

  end
end
