require 'spec_helper'

describe ItemsController do 
  describe "GET index" do
    it "sets @items" do 
      item1 = Item.create(description: "Item 1")
      item2 = Item.create(description: "Item 2")
      get :index
      assigns(:items).should match_array([item1, item2])
    end

  end

end