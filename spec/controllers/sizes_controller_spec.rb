require 'spec_helper'

describe SizesController do 
  describe "GET index" do 
    it "renders the index view" do 
      xhr :get, :index
      expect(response).to render_template :index
    end
    it "sets @sizes" do 
      big = Fabricate(:size)
      small = Fabricate(:size)
      xhr :get, :index
      expect(assigns(:sizes)).to match_array([big, small])
    end
  end
  
end
