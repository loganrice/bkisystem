require 'spec_helper'

describe DocumentsController do 
  describe "GET index" do 
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  

      it "renders the index view" do 
        xhr :get, :index
        expect(response).to render_template :index
      end
      it "sets @documents" do
        pack_list = Document.create(name: "pack list")
        inspection = Document.create(name: "inspection") 
        xhr :get, :index
        expect(assigns(:documents)).to match_array([pack_list, inspection])
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

      it "renders the new template" do 
        xhr :get, :new
        expect(response).to render_template :new
      end
      it "sets @document" do
        xhr :get, :new
        expect(assigns(:document)).to be_instance_of(Document)
      end
    end
  end

  describe "GET edit" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :edit, id: Document.create(name: "Shipping Report") }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  

      it "renders the edit template" do
        medium = Document.create(name: "medium") 
        xhr :get, :edit, id: medium.id
        expect(response).to render_template :edit 
      end
      it "sets @size" do 
        medium = Document.create(name: "medium")
        xhr :get, :edit, id: medium.id
        expect(assigns(:document)).to be_instance_of(Document)
      end
    end
  end

  describe "PUT update" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Document.create(name: "shipping document") }
      end
    end
    context "with authenticated user" do
      before { set_current_user } 

      context "with valid input" do
        let(:small) { Document.create(name: "small") }
        before(:each) {xhr :put, :update, id: small.id, document: { name: "small" }}

        it "redirects to the edit document path" do
          expect(response).to redirect_to edit_document_path(small)
        end
        it "updates the document name" do
          expect(Document.first.name).to eq("small")
        end
        it "sets the flash success message" do
          expect(flash[:success]).to be_present
        end
      end
      context "with invalid input" do
        let(:big) { Document.create(name: "big") }
        before(:each) {xhr :put, :update, id: big.id, document: { name: nil }}

        it "should not update document" do
          expect(Document.first.name).not_to be_nil
        end
        it "sets the flash error message" do 
          expect(flash[:error]).to be_present
        end
        it "renders the edit template" do
          expect(response).to render_template :edit
        end
      end
    end
  end
  describe "POST create" do 
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, size: Document.create(name: "shipping document")}
      end
    end
    context "with authenticated user" do
      before { set_current_user }  

      context "with valid input" do
        before(:each) { xhr :post, :create, {document: { name: "large" }} }
        
        it "redirects to the documents path" do
          expect(response).to redirect_to documents_path
        end
        it "creates a new document" do 
          expect(Document.first.name).to eq("large")
        end
        it "sets the flash success message" do
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid input" do
        before(:each) { xhr :post, :create, {document: { name: nil }} }

        it "renders the new template" do 
          expect(response).to render_template :new
        end
        it "does not create a size" do
          expect(Document.count).to eq(0)
        end
        it "sets the flash error message" do
          expect(flash[:error]).to be_present
        end
      end
    end
  end
end