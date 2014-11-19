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

  describe 'GET edit' do 
    it "sets @item" do
      item = Fabricate(:item)
      xhr :get, :edit, id: item.id 
      assigns(:item).should == item 
    end

    it "renders the edit template" do 
      item = Item.create(description: "Item one")
      xhr :get, :edit, id: item.id
      response.should render_template :edit
    end
  end

  describe "PUT update" do
    let(:item) { Fabricate(:item) }
    
    it "sets @item" do
      put :update, { "id" => item.id, "item" => { description: "A new description" } }
      item.reload
      item.description.should eq("A new description")
    end

    it "changes @item attributes" do 
      put :update, { "id" => item.id, "item" => { description: "A new description" } }
      assigns(:item).should eq(item)
    end

    it "redireccts to the @item edit page" do 
      put :update, { "id" => item.id, "item" => { description: "A new description" } }
      response.should redirect_to edit_item_path(item)
    end

    it "sets the flash success message" do 
      put :update, { "id" => item.id, "item" => { description: "A new description" } }
      flash[:success].should be_present
    end

    it "sets the flash error message" do 
      put :update, { "id" => item.id, "item" => { description: nil } }
      flash[:error].should be_present
    end
  end
end