require 'spec_helper'

describe AjaxController do 
  describe 'GET item_names' do 
    it "returns a json list"
    it "searches for items matching terms" do 
      butte1 = Fabricate(:item, name: "Butte 1")
      butte2 = Fabricate(:item, name: "Butte 2") 
      nonpareil = Fabricate(:item, name: "nonpareil")
      get :item_names, term: 'but'
      body = JSON.parse(response.body)

      body.should have(2).items
    end
  end
end