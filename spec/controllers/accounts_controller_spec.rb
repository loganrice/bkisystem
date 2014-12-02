require 'spec_helper'

describe AccountsController do 
  describe 'GET index' do 
    it "should set the accounts instance variable" do 
      Fabricate(:account)
      Fabricate(:account)
      xhr :get, :index
      expect(assigns(:accounts)).to be_present
    end
    it "should render the accounts index view" do 
      xhr :get, :index
      expect(response).to render_template :index
    end
  end

  describe 'GET new' do 
    it "sets @account with new account instance" do 
      xhr :get, :new
      expect(assigns(:account)).to be_instance_of(Account)
    end

    it "renders the new template" do 
      xhr :get, :new
      expect(response).to render_template :new
    end
  end

  describe 'GET edit' do
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

  describe 'POST create' do    
    context "with valid input" do
      let(:new_account_attributes) { Fabricate.attributes_for(:account) }

      it "creates a new account" do
        xhr :post, :create, account: new_account_attributes
        expect(Account.count).to eq(1)
      end
      it "redirects to the accounts path" do 
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

  describe 'PUT update' do
    before(:each) { Fabricate(:account) }

    context "with valid input" do 
      it "udpates account with new name" do
        xcorp = Account.first
        xhr :put, :update, id: xcorp.id, account: {name: "X Corp"} 
        expect(Account.first.name).to eq("X Corp")
      end

      it "redirects to the accounts path" do
        xcorp = Account.first
        xhr :put, :update, id: xcorp.id, account: xcorp.attributes
        expect(response).to redirect_to accounts_path
      end
      it "sets the flash success message" do
        xcorp = Account.first
        xcorp.name = "X Corp"
        xhr :put, :update, id: xcorp.id, account: {name: "X Corp"}
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid input" do 
      it "should render the edit template" do
        xcorp = Account.first
        xhr :put, :update, id: xcorp.id, account: {name: nil }
        expect(response).to render_template :edit
      end
      it "does not update account name" do
        xcorp = Account.first
        xhr :put, :update, id: xcorp.id, account: {name: nil }
        expect(Account.first.name).to_not be_nil
      end

      it "sets the flash error message" do
        xcorp = Account.first
        xhr :put, :update, id: xcorp.id, account: {name: nil }
        expect(flash[:error]).to be_present
      end
    end
  end
end