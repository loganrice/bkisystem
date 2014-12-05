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
end