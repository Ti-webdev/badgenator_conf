require 'spec_helper'

describe BadgeSetsController do

  let(:valid_attributes) { FactoryGirl.attributes_for(:badge_set) }

  describe "GET index" do
    it "assigns all badge_sets as @badge_sets" do
      badge_set = FactoryGirl.create(:badge_set)
      get :index, {}
      assigns(:badge_sets).should eq([badge_set])
    end
  end

  describe "GET new" do
    it "assigns a new badge_set as @badge_set" do
      get :new, {}
      assigns(:badge_set).should be_a_new(BadgeSet)
    end
  end

  describe "GET edit" do
    it "assigns the requested badge_set as @badge_set" do
      badge_set = FactoryGirl.create(:badge_set)
      get :edit, {id: badge_set.to_param}
      assigns(:badge_set).should eq(badge_set)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new BadgeSet" do
        expect {
          post :create, {badge_set: valid_attributes}
        }.to change(BadgeSet, :count).by(1)
      end

      # it "creates a new BadgeSet if image is not specified" do
      #   expect {
      #     post :create, {:badge_set => valid_attributes.except(:image)}
      #   }.to change(BadgeSet, :count).by(1)
      # end

      # it "creates a new BadgeSet if source is not specified" do
      #   expect {
      #     post :create, {:badge_set => valid_attributes.except(:source)}
      #   }.to change(BadgeSet, :count).by(1)
      # end

      # it "creates a new BadgeSet if name is not specified" do
      #   expect {
      #     post :create, {:badge_set => valid_attributes.except(:name)}
      #   }.to change(BadgeSet, :count).by(1)
      # end

      # it "creates a new BadgeSet with source file name if name is not specified" do
      #   post :create, {:badge_set => valid_attributes.except(:name)}
      #   BadgeSet.last.name.should == 'badges'
      # end

      it "assigns a newly created badge_set as @badge_set" do
        post :create, {badge_set: valid_attributes}
        assigns(:badge_set).should be_a(BadgeSet)
        assigns(:badge_set).should be_persisted
      end

      it "redirects to the created badge_set badges" do
        post :create, {badge_set: valid_attributes}
        response.should redirect_to(badge_set_badges_url(BadgeSet.last))
      end
    end

    describe "with invalid params" do
      it "rejects a new BadgeSet with invalid params" do
        expect {
          post :create, {badge_set: {  }}
        }.to_not change(BadgeSet, :count)
      end

      it "re-renders the 'new' template" do
        post :create, {badge_set: {  }}
        response.should render_template("new")
      end

      context "error reporting" do
        render_views

        it "renders validation errors" do
          post :create, {badge_set: {  }}
          assigns(:badge_set).errors.full_messages.each do |message|
            response.body.should have_content(message)
          end 
        end  
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:badge_set) { FactoryGirl.create(:badge_set) }

      it "updates the requested badge_set" do
        BadgeSet.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {id: badge_set.to_param, badge_set: { "these" => "params" }}
      end

      it "assigns the requested badge_set as @badge_set" do
        put :update, {id: badge_set.to_param, badge_set: valid_attributes}
        assigns(:badge_set).should eq(badge_set)
      end

      it "redirects to the badge_set badges" do
        put :update, {id: badge_set.to_param, badge_set: valid_attributes}
        response.should redirect_to(badge_set_badges_url(badge_set))
      end
    end

    describe "with invalid params" do
      let(:badge_set) { FactoryGirl.create(:badge_set) }

      it "re-renders the 'edit' template" do
        put :update, {id: badge_set.to_param, badge_set: {name: nil}}
        response.should render_template("edit")
      end

      context "error reporting" do
        render_views

        it "renders validation errors" do
          put :update, {id: badge_set.to_param, badge_set: {name: nil}}
          assigns(:badge_set).errors.full_messages.each do |message|
            response.body.should have_content(message)
          end 
        end  
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested badge_set" do
      badge_set = FactoryGirl.create(:badge_set)
      expect {
        delete :destroy, {id: badge_set.to_param}
      }.to change(BadgeSet, :count).by(-1)
    end

    it "destroys all badges for requested badge_set" do
      badge_set = FactoryGirl.create(:badge_set_with_badges, badges_count: 5)
      expect {
        delete :destroy, {id: badge_set.to_param}
      }.to change(Badge, :count).from(5).to(0)
    end

    it "redirects to the badge_sets list" do
      badge_set = FactoryGirl.create(:badge_set)
      delete :destroy, {id: badge_set.to_param}
      response.should redirect_to(badge_sets_url)
    end
  end

end
