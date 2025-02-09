require 'spec_helper'

describe AccountsController do
  describe 'GET index' do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      it "sets the accounts instance variable" do 
        Fabricate(:account)
        Fabricate(:account)
        xhr :get, :index
        expect(assigns(:accounts)).to be_present
      end
      it "renders the accounts index view" do 
        xhr :get, :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET new' do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :new }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      it "sets @account with new account instance" do 
        xhr :get, :new
        expect(assigns(:account)).to be_instance_of(Account)
      end

      it "renders the new template" do 
        xhr :get, :new
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET edit' do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :edit, id: Fabricate(:account).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      it "sets @account with new account instance" do 
        xcorp = Fabricate(:account)
        xhr :get, :edit, id: xcorp.id 
        expect(assigns(:account)).to be_instance_of(Account)
      end

      it "renders the edit template" do
        xcorp = Fabricate(:account)
        xhr :get, :edit, id: xcorp.id
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :delete, :destroy, id: Fabricate(:account).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }
      context "with valid input" do
        it "deletes an account" do 
          xcorp = Fabricate(:account)
          xhr :delete, :destroy, id: xcorp.id
          expect(Account.count).to eq(0)
        end

        it "redirects to accounts path" do 
          xcorp = Fabricate(:account)
          xhr :delete, :destroy, id: xcorp.id
          expect(response).to redirect_to accounts_path
        end

        it "sets the flash success message" do 
          xcorp = Fabricate(:account)
          xhr :delete, :destroy, id: xcorp.id
          expect(flash[:success]).to be_present
        end
      end
    end
  end

  describe 'POST create' do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, account: Fabricate.attributes_for(:account) }
      end
    end
    context "with authenticated user" do
      before { set_current_user }   
      context "with valid input" do
        let(:new_account_attributes) { Fabricate.attributes_for(:account) }

        it "creates a new account" do
          xhr :post, :create, account: new_account_attributes
          expect(Account.count).to eq(1)
        end
        it "redirect to the accounts path" do 
          xhr :post, :create, account: new_account_attributes
          expect(response).to redirect_to accounts_path
        end
        it "creates the flash success message" do 
          xhr :post, :create, account: new_account_attributes
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid input" do 
        it "does not create a new account" do
          xhr :post, :create, account: { name: nil }
          expect(Account.count).to eq(0)
        end
        it "renders the new template" do 
          xhr :post, :create, account: { name: nil }
          expect(response).to render_template :new
        end
        it "sets the flash error message" do 
          xhr :post, :create, account: { name: nil }
          expect(flash[:error]).to be_present
        end
      end
    end
  end

  describe 'PUT update' do
    before(:each) { Fabricate(:account) }
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Fabricate(:account).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }      
      context "with valid input" do 
        it "udpates account with new name" do
          xcorp = Account.first
          xhr :put, :update, id: xcorp.id, account: {name: "X Corp"} 
          expect(Account.first.name).to eq("X Corp")
        end

        it "render edit template" do
          xcorp = Account.first
          xhr :put, :update, id: xcorp.id, account: xcorp.attributes
          expect(response).to render_template :edit
        end
        it "sets the flash success message" do
          xcorp = Account.first
          xcorp.name = "X Corp"
          xhr :put, :update, id: xcorp.id, account: {name: "X Corp"}
          expect(flash[:success]).to be_present
        end
      end
    end
  end
end