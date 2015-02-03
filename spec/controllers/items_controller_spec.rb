require 'spec_helper'

describe ItemsController do 
  describe "GET index" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  

      it "sets @items" do 
        item1 = Fabricate(:item)
        item2 = Fabricate(:item)
        xhr :get, :index
        assigns(:items).should match_array([item1, item2])
      end
    end
  end

  describe 'GET edit' do 
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :edit, id: Fabricate(:item).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  
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
  end

  describe "GET new" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :new }
      end
    end
    context "with authenticated user" do
      before { set_current_user } 

      it "sets @item with a new instance variable" do 
        xhr :get, :new
        assigns(:item).should be_instance_of(Item)
      end
    end
  end

  describe "POST create" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, item: Fabricate.attributes_for(:item) }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  
      let(:item_attributes) { Fabricate.attributes_for(:item)}
      context "with valid input" do
        let(:almond) { Fabricate(:commodity) }

        it "redirects to the items path" do 
          xhr :post, :create, item: item_attributes
          response.should redirect_to items_path
        end
        it "creates an item" do
          xhr :post, :create, item: item_attributes
          Item.count.should eq(1)
        end
        it "sets the flash success message" do
          xhr :post, :create, item: item_attributes
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
  end

  describe "PUT update" do
    let(:item) { Fabricate(:item) }
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Fabricate(:item).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  
      it "sets @item with the updated item instance" do
        xhr :put, :update, { "id" => item.id, "item" => { name: "A new name" } }
        item.reload
        item.name.should eq("A new name")
      end

      it "changes @item name" do 
        xhr :put, :update, { "id" => item.id, "item" => { name: "A new name" } }
        assigns(:item).should eq(item)
      end

      it "assigns a commodity to an item" do
        almond = Commodity.create(name: "Almonds")
        xhr :put, :update, { "id" => item.id, "item" => { description: item.name, commodity_id: almond.id } }
        item.reload
        expect(item.commodity).to eq(almond)
      end

      it "assigns a size to an item" do 
        medium = Fabricate(:size, name: "medium")
        xhr :put, :update, { "id" => item.id, "item" => { name: item.name, commodity_id: item.commodity.id, size_id: medium.id } }
        item.reload
        expect(item.size).to eq(medium)
      end

      it "assigns a variety to an item" do 
        carmel = Variety.create(name: "carmel")
        xhr :put, :update, { "id" => item.id, "item" => { name: item.name, variety_id: carmel.id } }
        item.reload
        expect(item.variety).to eq(carmel)
      end

      it "redirects to the @item edit page" do 
        xhr :put, :update, { "id" => item.id, "item" => { name: "A new name" } }
        response.should redirect_to edit_item_path(item)
      end

      it "sets the flash success message" do 
        xhr :put, :update, { "id" => item.id, "item" => { name: "A new name" } }
        flash[:success].should be_present
      end

      it "sets the flash error message" do 
        xhr :put, :update, { "id" => item.id, "item" => { name: nil } }
        flash[:error].should be_present
      end
    end
  end
end