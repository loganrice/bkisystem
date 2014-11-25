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
  describe "GET new" do
    it "renders the new template" do 
      xhr :get, :new
      expect(response).to render_template :new
    end
    it "sets @size" do
      xhr :get, :new
      expect(assigns(:size)).to be_instance_of(Size)
    end
  end

  describe "GET edit" do
    it "renders the edit template" do
      medium = Size.create(name: "medium") 
      xhr :get, :edit, id: medium.id
      expect(response).to render_template :edit 
    end
    it "sets @size" do 
      medium = Size.create(name: "medium")
      xhr :get, :edit, id: medium.id
      expect(assigns(:size)).to be_instance_of(Size)
    end
  end

  describe "PUT update" do 
    context "with valid input" do
      let(:small) { Fabricate(:size) }
      before(:each) {xhr :put, :update, id: small.id, size: { name: "small" }}

      it "redirects to the edit size path" do
        expect(response).to redirect_to edit_size_path(small)
      end
      it "updates the size name" do
        expect(Size.first.name).to eq("small")
      end
      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end
    context "with invalid input" do
      let(:big) { Fabricate(:size) }
      before(:each) {xhr :put, :update, id: big.id, size: { name: nil }}

      it "should not update size" do
        expect(Size.first.name).not_to be_nil
      end
      it "sets the flash error message" do 
        expect(flash[:error]).to be_present
      end
      it "renders the edit template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "POST create" do 
    context "with valid input" do
      before(:each) { xhr :post, :create, {size: { name: "large" }} }
      
      it "redirects to the sizes path" do
        expect(response).to redirect_to sizes_path
      end
      it "creates a new size" do 
        expect(Size.first.name).to eq("large")
      end
      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid input" do
      before(:each) { xhr :post, :create, {size: { name: nil }} }

      it "renders the new template" do 
        expect(response).to render_template :new
      end
      it "does not create a size" do
        expect(Size.count).to eq(0)
      end
      it "sets the flash error message" do
        expect(flash[:error]).to be_present
      end
    end
  end
end
