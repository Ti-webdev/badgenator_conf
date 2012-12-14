require 'spec_helper'

describe BadgesController do

  # This should return the minimal set of attributes required to create a valid
  # Badge. As you add validations to Badge, be sure to
  # update the return value of this method accordingly.
  let(:badge_set) do
    BadgeSet.create!({
      name: 'rails days',
      image: fixture_file_upload('/logo.png', 'image/png')
    })
  end
 
  let(:valid_attributes) { {name: 'Jonny', company: 'Pirate'} }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BadgesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all badges as @badges" do
      badge = badge_set.badges.create! valid_attributes
      get :index, {badge_set_id: badge_set.to_param}, valid_session
      assigns(:badges).should eq([badge])
    end
  end

  describe "GET show" do
    it "assigns the requested badge as @badge" do
      badge = badge_set.badges.create! valid_attributes
      get :show, {id: badge.to_param, badge_set_id: badge_set.to_param}, valid_session
      assigns(:badge).should eq(badge)
    end
  end

  describe "GET new" do
    it "assigns a new badge as @badge" do
      get :new, {badge_set_id: badge_set.to_param}, valid_session
      assigns(:badge).should be_a_new(Badge)
    end
  end

  describe "GET edit" do
    it "assigns the requested badge as @badge" do
      badge = badge_set.badges.create! valid_attributes
      get :edit, {id: badge.to_param, badge_set_id: badge_set.to_param}, valid_session
      assigns(:badge).should eq(badge)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Badge" do
        expect {
          post :create, {badge: valid_attributes, badge_set_id: badge_set.to_param}, valid_session
        }.to change(Badge, :count).by(1)
      end

      it "assigns a newly created badge as @badge" do
        post :create, {badge: valid_attributes, badge_set_id: badge_set.to_param}, valid_session
        assigns(:badge).should be_a(Badge)
        assigns(:badge).should be_persisted
      end

      it "redirects to the created badge" do
        post :create, {badge: valid_attributes, badge_set_id: badge_set.to_param}, valid_session
        response.should redirect_to([badge_set, Badge.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved badge as @badge" do
        # Trigger the behavior that occurs when invalid params are submitted
        Badge.any_instance.stub(:save).and_return(false)
        post :create, {badge: {}, badge_set_id: badge_set.to_param}, valid_session
        assigns(:badge).should be_a_new(Badge)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Badge.any_instance.stub(:save).and_return(false)
        post :create, {badge: {}, badge_set_id: badge_set.to_param}, valid_session
        response.should render_template("new")
      end
      
      context "error reporting" do
        render_views

        it "renders validation errors" do
          post :create, {badge: {company: nil}, badge_set_id: badge_set.to_param}, valid_session
          assigns(:badge).errors.full_messages.each do |message|
            response.body.should have_content(message)
          end 
        end  
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested badge" do
        badge = badge_set.badges.create! valid_attributes
        # Assuming there are no other badges in the database, this
        # specifies that the Badge created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Badge.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {id: badge.to_param, badge: { "these" => "params" }, badge_set_id: badge_set.to_param}, valid_session
      end

      it "assigns the requested badge as @badge" do
        badge = badge_set.badges.create! valid_attributes
        put :update, {id: badge.to_param, badge: valid_attributes, badge_set_id: badge_set.to_param}, valid_session
        assigns(:badge).should eq(badge)
      end

      it "redirects to the badge" do
        badge = badge_set.badges.create! valid_attributes
        put :update, {id: badge.to_param, badge: valid_attributes, badge_set_id: badge_set.to_param}, valid_session
        response.should redirect_to(badge_set_badges_url badge_set)
      end
    end

    describe "with invalid params" do
      it "assigns the badge as @badge" do
        badge = badge_set.badges.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Badge.any_instance.stub(:save).and_return(false)
        put :update, {id: badge.to_param, badge: {}, badge_set_id: badge_set.to_param}, valid_session
        assigns(:badge).should eq(badge)
      end

      it "re-renders the 'edit' template" do
        badge = badge_set.badges.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Badge.any_instance.stub(:save).and_return(false)
        put :update, {id: badge.to_param, badge: {}, badge_set_id: badge_set.to_param}, valid_session
        response.should render_template("edit")
      end
      
      context "error reporting" do
        render_views

        it "renders validation errors" do
          badge = badge_set.badges.create! valid_attributes
          post :update, {id: badge.to_param, badge: {company: nil}, badge_set_id: badge_set.to_param}, valid_session
          assigns(:badge).errors.full_messages.each do |message|
            response.body.should have_content(message)
          end 
        end  
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested badge" do
      badge = badge_set.badges.create! valid_attributes
      expect {
        delete :destroy, {id: badge.to_param, badge_set_id: badge_set.to_param}, valid_session
      }.to change(Badge, :count).by(-1)
    end

    it "redirects to the badges list" do
      badge = badge_set.badges.create! valid_attributes
      delete :destroy, {id: badge.to_param, badge_set_id: badge_set.to_param}, valid_session
      response.should redirect_to(badge_set_badges_url badge_set)
    end
  end

end
