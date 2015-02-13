require 'spec_helper'

describe InvoicesController do 
  describe 'GET edit' do
    context "with valid input" do  
      let(:order) { Fabricate(:order) }

      it "sets @order" do 
        xhr :get, :edit, id: order.id
        expect(assigns(:order)).to be_instance_of(Order)
      end

      it "renders the edit template" do
        xhr :get, :edit, id: order.id
        expect(response).to render_template :edit 
      end
    end
  end
  describe 'PUT update' do 
    it "updates the order" do 
      seller = Fabricate(:account)
      buyer = Fabricate(:account)
      bank1 = Fabricate(:bank)
      bank2 = Fabricate(:bank)
      seller.banks << bank1
      seller.banks << bank2
      seller.addresses << Fabricate(:address)

      contract = Fabricate(:contract, buyer_id: buyer.id, seller_id: seller.id)
      order = Fabricate(:order, contract_id: contract.id)

      xhr :put, :update, id: order.id, order: order.attributes
      expect(order.bank).to eq(bank2)
    end
    it "redirects to the invoice report"

  end
end