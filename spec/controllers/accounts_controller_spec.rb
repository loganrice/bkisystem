require 'spec_helper'

describe AccountsController do 
  describe 'GET index' do 
    it "should set the accounts instance variable" do 
      Fabricate(:account)
      Fabricate(:account)
      xhr :get, :index
      expect(assigns(:accounts)).should be_present
    end
    it "should render the accounts index view" do 
      xhr :get, :index
      expect(response).to render_template :index
    end
  end
end