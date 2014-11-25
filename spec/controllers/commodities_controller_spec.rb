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

  describe "GET new" do
    it "sets @commodity with a new instance variable" do 
      xhr :get, :new
      assigns(:commodity).should be_instance_of(Commodity)
    end
  end

  describe "POST create" do
    context "with valid input" do
      it "redirects to the commodities path" do 
        xhr :post, :create, commodity: { description: "almonds" }
        response.should redirect_to commodities_path
      end
      it "creates an commodity" do
        xhr :post, :create, commodity: { description: "almonds" }
        Commodity.count.should eq(1)
      end
      it "sets the flash success message" do
        xhr :post, :create, commodity: { description: "almonds" }
        flash[:success].should be_present
      end

    end
    context "with invalid input" do 
      it "renders the new commodity page" do 
        xhr :post, :create
        response.should render_template :new
      end

      it "does not create an commodity" do 
        xhr :post, :create
        Commodity.count.should eq(0)
      end
      it "sets the flash error message" do 
        xhr :post, :create
        flash[:error].should be_present
      end
    end
  end

  describe 'GET edit' do 
    it "sets @commodity" do
      almonds = Fabricate(:commodity)
      xhr :get, :edit, id: almonds.id 
      assigns(:commodity).should == almonds 
    end

    it "renders the edit template" do
      almonds = Fabricate(:commodity)
      xhr :get, :edit, id: almonds.id
      response.should render_template :edit
    end
  end

  describe "PUT update" do
    let(:almonds) { Fabricate(:commodity) }
    
    context "with valid input" do 
      it "sets @commodity with the updated commodity instance" do
        xhr :put, :update, { "id" => almonds.id, "commodity" => { description: "A new description" } }
        almonds.reload
        almonds.description.should eq("A new description")
      end

      it "changes @commodity description" do 
        xhr :put, :update, { "id" => almonds.id, "commodity" => { description: "A new description" } }
        assigns(:commodity).should eq(almonds)
      end

      it "redirects to the @commodity edit page" do 
        xhr :put, :update, { "id" => almonds.id, "commodity" => { description: "A new description" } }
        response.should redirect_to edit_commodity_path(almonds)
      end

      it "sets the flash success message" do 
        xhr :put, :update, { "id" => almonds.id, "commodity" => { description: "A new description" } }
        flash[:success].should be_present
      end
    end

    context "with invalid input" do
      let(:almonds) { Fabricate(:commodity) }

      it "sets the flash error message" do 
        xhr :put, :update, { "id" => almonds.id, "commodity" => { description: nil } }
        flash[:error].should be_present
      end

      it "renders the edit template" do 
        xhr :put, :update, { "id" => almonds.id, "commodity" => { description: nil } }
        response.should render_template :edit
      end
    end
  end

end
