require "spec_helper"

describe BadgesController do
  describe "routing" do

    it "routes to #index" do
      get("/archive/1/badges").should route_to("badges#index", :badge_set_id => "1")
    end

    it "routes to #index with page" do
      get("/archive/1/badges/page/2").should route_to("badges#index", :badge_set_id => "1", :page => "2")
    end

    it "routes to #new" do
      get("/archive/1/badges/new").should route_to("badges#new", :badge_set_id => "1")
    end

    it "routes to #show" do
      get("/archive/1/badges/1").should route_to("badges#show", :id => "1", :badge_set_id => "1")
    end

    it "routes to #edit" do
      get("/archive/1/badges/1/edit").should route_to("badges#edit", :id => "1", :badge_set_id => "1")
    end

    it "routes to #create" do
      post("/archive/1/badges").should route_to("badges#create", :badge_set_id => "1")
    end

    it "routes to #update" do
      put("/archive/1/badges/1").should route_to("badges#update", :id => "1", :badge_set_id => "1")
    end

    it "routes to #destroy" do
      delete("/archive/1/badges/1").should route_to("badges#destroy", :id => "1", :badge_set_id => "1")
    end

  end
end
