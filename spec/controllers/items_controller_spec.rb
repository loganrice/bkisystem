require 'spec_helper'

describe ItemsController do 
  describe "GET index" do
    it "sets @items" do 
      item1 = Fabricate(:item)
      item2 = Fabricate(:item)
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
      item = Fabricate(:item)
      xhr :get, :edit, id: item.id
      response.should render_template :edit
    end
  end

  describe "GET new" do 
    it "sets @item with a new instance variable" do 
      xhr :get, :new
      assigns(:item).should be_instance_of(Item)
    end
  end

  describe "POST create" do
    context "with valid input" do
      let(:almond) { Fabricate(:commodity) }

      it "redirects to the items path" do 
        xhr :post, :create, item: { description: "5lb box", commodity_id: almond.id }
        response.should redirect_to items_path
      end
      it "creates an item" do
        xhr :post, :create, item: { description: "5lb box", commodity_id: almond.id }
        Item.count.should eq(1)
      end
      it "sets the flash success message" do
        xhr :post, :create, item: { description: "5lb box", commodity_id: almond.id }
        flash[:success].should be_present
      end

    end
    context "with invalid input" do 
      it "renders the new item page" do 
        xhr :post, :create
        response.should render_template :new
      end

      it "does not create an item" do 
        xhr :post, :create
        Item.count.should eq(0)
      end
      it "sets the flash error message" do 
        xhr :post, :create
        flash[:error].should be_present
      end
    end
  end

  describe "PUT update" do
    let(:item) { Fabricate(:item) }
    
    it "sets @item with the updated item instance" do
      xhr :put, :update, { "id" => item.id, "item" => { description: "A new description" } }
      item.reload
      item.description.should eq("A new description")
    end

    it "changes @item description" do 
      xhr :put, :update, { "id" => item.id, "item" => { description: "A new description" } }
      assigns(:item).should eq(item)
    end

    it "assigns a commodity to an item" do
      almond = Commodity.create(description: "Almonds")
      xhr :put, :update, { "id" => item.id, "item" => { description: item.description, commodity_id: almond.id } }
      item.reload
      expect(item.commodity).to eq(almond)
    end

    it "assigns a size to an item" do 
      medium = Fabricate(:size, name: "medium")
      xhr :put, :update, { "id" => item.id, "item" => { description: item.description, commodity_id: item.commodity.id, size_id: medium.id } }
      item.reload
      expect(item.size).to eq(medium)
    end

    it "assigns a variety to an item" do 
      carmel = Variety.create(name: "carmel")
      xhr :put, :update, { "id" => item.id, "item" => { description: item.description, variety_id: carmel.id } }
      item.reload
      expect(item.variety).to eq(carmel)
    end

    it "redirects to the @item edit page" do 
      xhr :put, :update, { "id" => item.id, "item" => { description: "A new description" } }
      response.should redirect_to edit_item_path(item)
    end

    it "sets the flash success message" do 
      xhr :put, :update, { "id" => item.id, "item" => { description: "A new description" } }
      flash[:success].should be_present
    end

    it "sets the flash error message" do 
      xhr :put, :update, { "id" => item.id, "item" => { description: nil } }
      flash[:error].should be_present
    end
  end
end