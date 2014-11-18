require 'spec_helper'

describe ItemsController do 
  describe "GET index" do
    it "sets @items" do 
      item1 = Item.create(description: "Item 1")
      item2 = Item.create(description: "Item 2")
      xhr :get, :index
      assigns(:items).should match_array([item1, item2])
    end
  end

  describe 'GET show' do 
    it "sets @item" do 
      item = Item.create(description: "Item one")
      get :show, id: item.id 
      assigns(:item).should == item 
    end

    it "renders the show template" do 
      item = Item.create(description: "Item one")
      get :show, id: item.id
      response.should render_template :show
    end
    it "responds to js"
  end
end