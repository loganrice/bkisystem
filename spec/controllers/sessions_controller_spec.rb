require 'spec_helper'

describe SessionsController do 
  describe "GET new" do
    context "when a user is already signed in" do 
      it "redirects to home path" do 
        set_current_user
        xhr :get, :new
        response.should redirect_to home_path
      end
    end
    context "when a user is not signed in" do 
      it "redirects to home path" do 
        xhr :get, :new
        response.should render_template :new
      end
    end
  end
  describe "DELETE destroy" do 
    before do 
      set_current_user
    end

    it "clears the user cookie" do 
      get :destroy
      session[:user_id].should be_nil
    end

    it "redirects to the root path" do 
      get :destroy
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do
    context "authenticated user" do 
      it "sets the session[:user_id]" do
        bob = Fabricate(:user)
        post :create, email: bob.email, password: bob.password
        session[:user_id].should == bob.id 
      end
      it "redirects to home_path" do
        bob = Fabricate(:user)
        post :create, email: bob.email, password: bob.password
        response.should redirect_to home_path
      end

    end

    context "unauthenticated user" do
      it "redirects to login_path" do
        post :create
        response.should redirect_to sign_in_path
      end
    end
  end
end