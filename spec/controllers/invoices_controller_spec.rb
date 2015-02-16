require 'spec_helper'

describe InvoicesController do
  describe "GET index" do 
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index } 
      end
    end

    context "with authenticated user" do 
      before { set_current_user } 

      it "sets @invoices" do
        order = Fabricate(:order)
        invoice1 = Fabricate(:invoice, order_id: order.id)
        invoice2 = Fabricate(:invoice, order_id: order.id) 
        xhr :get, :index
        expect(assigns(:invoices)).to include(invoice1, invoice2) 
      end
      it "renders the index template" do 
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
      let(:order) { Fabricate(:order)}
      before { set_current_user }   

      it "sets @invoice" do 
        xhr :get, :new, order_id: order.id
        expect(assigns(:invoice)).to be_instance_of(Invoice)
      end

      it "sets @order" do
        order = Fabricate(:order)
        xhr :get, :new, order_id: order.id 
        expect(assigns(:order)).to be_instance_of(Order) 
      end
      it "renders the new template" do 
        xhr :get, :new, order_id: order.id
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST create' do 
    context "with authenticated user" do
      let(:payee) { Fabricate(:account)}
      let(:payer) { Fabricate(:account)}
      let(:bank1) { Fabricate(:bank, account_id: payee.id)}
      let(:bank2) { Fabricate(:bank, account_id: payer.id)}
      let(:address1) { Fabricate(:address)}
      let(:contract) { Fabricate(:contract)}
      let(:order) { Fabricate(:order, contract_id: contract.id)}
      before { set_current_user }

      context "with valid input" do 
        it "redirects to the edit invoice path" do
          xhr :post, :create, invoice: { payee_id: payee.id, payer_id: payer.id, bank_id: bank1.id, address_id: address1.id, order_id: order.id }
          expect(response).to redirect_to edit_invoice_path(Invoice.first)
        end

        it "creates an invoice" do 
          expect {
            xhr :post, :create, invoice: { payee_id: payee.id, payer_id: payer.id, bank_id: bank1.id, address_id: address1.id, order_id: order.id }
          }.to change(Invoice, :count).by(1)
        end
        it "sets the flash success message" do
          xhr :post, :create, invoice: { payee_id: payee.id, payer_id: payer.id, bank_id: bank1.id, address_id: address1.id, order_id: order.id }
          expect(flash[:success]).to be_present      
        end

      end

      context "with invalid input" do 
        it "renders the new template" do 
          xhr :post, :create, invoice: { payee_id: payee.id }
          expect(response).to render_template :new
        end

        it "does not create an invoice" do 
          xhr :post, :create, invoice: { payee_id: payee.id }
          expect(Invoice.count).to eq(0)
        end
        it "sets the flash error message" do 
          xhr :post, :create, invoice: { payee_id: payee.id }
          expect(flash[:error]).to be_present 
        end
      end
    end

  end

  describe 'GET edit' do
    context "with valid input" do  
      let(:invoice) { Fabricate(:invoice, order_id: Fabricate(:order).id) }
      before { set_current_user }

      it "sets @invoice" do
        xhr :get, :edit, id: invoice.id
        expect(assigns(:invoice)).to be_instance_of(Invoice)
      end

      it "renders the edit template" do
        xhr :get, :edit, id: invoice.id
        expect(response).to render_template :edit 
      end
    end
  end

  describe 'PUT update' do
    let(:payee) { Fabricate(:account)}
    let(:payer) { Fabricate(:account)}
    let(:bank1) { Fabricate(:bank, account_id: payee.id)}
    let(:bank2) { Fabricate(:bank, account_id: payer.id)}
    let(:address1) { Fabricate(:address)}
    let(:contract) { Fabricate(:contract)}
    let(:order) { Fabricate(:order, contract_id: contract.id)}
    let(:invoice) { Fabricate(:invoice, order_id: order.id)}

    context "with authenticated user" do
      before { set_current_user }   
      context "with valid input" do 
        it "updates the invoice" do
          bank_of_america = Fabricate(:bank, name: "Bank of America")
          xhr :put, :update, id: invoice.id, invoice: { payee_id: payee.id, payer_id: payer.id, bank_id: bank_of_america.id, address_id: address1.id, order_id: order.id }
          invoice.reload 
          expect(invoice.bank).to eq(bank_of_america)
        end
        it "redirects to the order path" do
          xhr :put, :update, id: invoice.id, invoice: { payee_id: payee.id, payer_id: payer.id, bank_id: bank1.id, address_id: address1.id, order_id: order.id }
          expect(response).to redirect_to edit_invoice_path(invoice)
        end

        it "sets the flash sucess message" do 
          xhr :put, :update, id: invoice.id, invoice: { payee_id: payee.id, payer_id: payer.id, bank_id: bank1.id, address_id: address1.id, order_id: order.id }
          expect(flash[:sucess]).to be_present
        end
      end

      context "with invalid input" do
        it "sets the flash error message" do
          xhr :put, :update, id: invoice.id, invoice: { payee_id: nil, payer_id: payer.id}
          expect(flash[:error]).to be_present
        end

        it "does not update the invoice" do
          old_payee = invoice.payee
          xhr :put, :update, id: invoice.id, invoice: { payee_id: nil, payer_id: payer.id}
          expect(invoice.payee).to eq(old_payee)
        end
        it "renders the edit template" do 
          xhr :put, :update, id: invoice.id, invoice: { payee_id: nil, payer_id: payer.id}
          expect(response).to render_template :edit
        end
        
      end
    end

    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: '1', invoice: { payee_id: '123' }}
      end
    end
  end
end