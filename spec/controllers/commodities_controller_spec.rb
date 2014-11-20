require 'spec_helper'

describe CommoditiesController do 
  describe "GET index" do 
    it "should set the commodities instance variable" do
      Fabricate(:commodity)
      Fabricate(:commodity)
      xhr :get, :index
      assigns(:commodities).should be_present
    end
    it "should render the index template" do 
      Fabricate(:commodity)
      xhr :get, :index
      response.should render_template :index
    end
  end

end
