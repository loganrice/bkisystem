require 'spec_helper'

describe VarietiesController do 
  describe "GET index" do 
    it "sets the variety instance variable" do 
      carmel = Fabricate(:variety)
      nonpareil = Fabricate(:variety)
      xhr :get, :index
      expect(assigns(:varieties)).to include(carmel, nonpareil)
    end

    it "renders the index template" do 
      xhr :get, :index
      expect(response).to render :index
    end
  end

end