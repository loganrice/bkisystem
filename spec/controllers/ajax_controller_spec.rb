require 'spec_helper'

describe AjaxController do 
  describe 'GET item_names' do 
    it "returns a json list"
    it "searches for items matching terms" do 
      get :item_names
      expect(response).to eq([])
    end
  end
end