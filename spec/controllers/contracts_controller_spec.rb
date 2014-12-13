require 'spec_helper'

describe ContractsController do 
  describe "GET index" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index }
      end
    end
    context "with authenticated user" do
      before { set_current_user }   
      it "sets @contracts" do 
        contract1 = Fabricate(:contract)
        contract2 = Fabricate(:contract)
        contract3 = Fabricate(:contract)
        xhr :get, :index
        expect(assigns(:contracts)).to match_array([contract1, contract2, contract3])
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

      it "sets @contract with a new instance variable" do 
        xhr :get, :new
        expect(assigns(:contract)).to be_instance_of(Contract)
      end

      it "renders the new template" do
        xhr :get, :new
        expect(response).to render_template :new
      end
    end
  end

  describe "GET edit" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :edit, id: Fabricate(:contract).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  
      let(:contract) { Fabricate(:contract)} 

      it "sets @contract" do 
        xhr :get, :edit, id: contract.id
        expect(assigns(:contract)).to be_instance_of(Contract)
      end
      it "renders the edit template" do
        xhr :get, :edit, id: contract.id
        expect(response).to render_template :edit
      end
    end
  end

  describe "PUT update" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Fabricate(:contract).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  

      context "with valid input" do
        let(:contract) { Fabricate(:contract) }

        it "sets @contract with updated buyer po" do
          xhr :put, :update, id: contract.id, contract: { buyer_po: "5555" }
          contract.reload
          expect(contract.buyer_po).to eq("5555")
        end

        it "updates the contract buyer id" do
          new_buyer = Fabricate(:account)
          xhr :put, :update, id: contract.id, contract: { buyer_id: new_buyer.id }
          contract.reload
          expect(contract.buyer).to eq(new_buyer)
        end

        it "updates the contract seller id" do 
          new_seller = Fabricate(:account)
          xhr :put, :update, id: contract.id, contract: { seller_id: new_seller.id }
          contract.reload
          expect(contract.seller).to eq(new_seller)
        end

        it "redirects to the contacts path" do
          xhr :put, :update, id: contract.id, contract: { buyer_po: "5555" }
          expect(response).to redirect_to contracts_path
        end
        it "sets the flash success message" do 
          xhr :put, :update, id: contract.id, contract: { buyer_po: "5555" }
          expect(flash[:success]).to_not be_nil
        end
      end

      context "with invalid input" do 
        it "does not update the buyer po"
        it "renders the edit template"
        it "sets the flash error message"
      end
    end
  end

  describe "POST create" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, contract: Fabricate.attributes_for(:contract) }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  

      context "with valid input" do 
        it "creates a contract" do 
          xhr :post, :create, contract: { buyer_contract: '1234', buyer_po: '23432', seller_contract: 'aa1345', date: Time.new.to_date }
          expect(Contract.count).to eq(1)
        end
        it "sets the flash success message" do 
          xhr :post, :create, contract: { buyer_contract: '1234', buyer_po: '23432', seller_contract: 'aa1345', date: Time.new.to_date }
          expect(flash[:success]).to be_present
        end
        it "redirects to the contracts path" do 
          xhr :post, :create, contract: { buyer_contract: '1234', buyer_po: '23432', seller_contract: 'aa1345', date: Time.new.to_date }
          expect(response).to redirect_to contracts_path
        end
      end
    end
  end
end