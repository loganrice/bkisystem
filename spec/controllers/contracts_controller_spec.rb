require 'spec_helper'

describe ContractsController do 
  describe "GET index" do 
    it "sets @contracts" do 
      contract1 = Fabricate(:contract)
      contract2 = Fabricate(:contract)
      contract3 = Fabricate(:contract)
      xhr :get, :index
      expect(assigns(:contracts)).to match_array([contract1, contract2, contract3])
    end
  end
  describe "GET new" do 
    it "sets @contract with a new instance variable" do 
      xhr :get, :new
      expect(assigns(:contract)).to be_instance_of(Contract)
    end
  end

  describe "POST create" do
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