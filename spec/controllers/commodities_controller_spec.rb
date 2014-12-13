require 'spec_helper'

describe CommoditiesController do 
  describe "GET index" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index }
      end
    end
    context "with authenticated user" do
      before { set_current_user }    
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
  end

  describe "GET new" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :new }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  

      it "sets @commodity with a new instance variable" do 
        xhr :get, :new
        assigns(:commodity).should be_instance_of(Commodity)
      end
    end
  end

  describe "POST create" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, commodity: Fabricate.attributes_for(:commodity) }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  

      context "with valid input" do
        it "redirects to the commodities path" do 
          xhr :post, :create, commodity: { name: "almonds" }
          response.should redirect_to commodities_path
        end
        it "creates an commodity" do
          xhr :post, :create, commodity: { name: "almonds" }
          Commodity.count.should eq(1)
        end
        it "sets the flash success message" do
          xhr :post, :create, commodity: { name: "almonds" }
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
  end

  describe 'GET edit' do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :edit, id: Fabricate(:commodity).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

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
  end

  describe "PUT update" do
    let(:almonds) { Fabricate(:commodity) }
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Fabricate(:commodity).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }      
      context "with valid input" do 
        it "sets @commodity with the updated commodity instance" do
          xhr :put, :update, { "id" => almonds.id, "commodity" => { name: "A new name" } }
          almonds.reload
          almonds.name.should eq("A new name")
        end

        it "changes @commodity name" do 
          xhr :put, :update, { "id" => almonds.id, "commodity" => { name: "A new name" } }
          assigns(:commodity).should eq(almonds)
        end

        it "redirects to the @commodity edit page" do 
          xhr :put, :update, { "id" => almonds.id, "commodity" => { name: "A new name" } }
          response.should redirect_to edit_commodity_path(almonds)
        end

        it "sets the flash success message" do 
          xhr :put, :update, { "id" => almonds.id, "commodity" => { name: "A new name" } }
          flash[:success].should be_present
        end
      end

      context "with invalid input" do
        let(:almonds) { Fabricate(:commodity) }

        it "sets the flash error message" do 
          xhr :put, :update, { "id" => almonds.id, "commodity" => { name: nil } }
          flash[:error].should 
        end

        it "renders the edit template" do 
          xhr :put, :update, { "id" => almonds.id, "commodity" => { name: nil } }
          response.should render_template :edit
        end
      end
    end
  end

end
