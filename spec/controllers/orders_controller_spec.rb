require 'spec_helper'

describe OrdersController do
  describe "GET index" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :edit, id: Fabricate(:order).id }
      end
    end

    context "with authenticated user" do
      before { set_current_user }   

      it "renders the index template" do 
        xhr :get, :index
        expect(response).to render_template(:index)
      end

      it "sets @orders" do
        order1 = Fabricate(:order)
        order2 = Fabricate(:order)
        order3 = Fabricate(:order)
        xhr :get, :index
        expect(assigns(:orders)).to match_array([order1, order2, order3])
      end
    end
  end

  describe "GET edit" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :edit, id: Fabricate(:order).id }
      end
    end

    context "with authenticated user" do 
      before { set_current_user }

      it "renders the edit template" do
        order = Fabricate(:order)
        xhr :get, :edit, id: order.id
        expect(response).to render_template :edit
      end
      it "sets @order" do 
        order = Fabricate(:order)
        xhr :get, :edit, id: order.id
        expect(assigns(:order)).to eq(order)
      end

      it "builds a commission if blank" do 

        order = Fabricate(:order)
        xhr :get, :edit, id: order.id
        expect(assigns(:order).commissions.count).to eq(1)
      end

    end
  end

  describe "PUT update" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :edit, id: Fabricate(:order).id }
      end
    end
    context "with authenticated user" do 
      before { set_current_user }

      context "with valid input" do 
        it "updates an order's voyage" do
          order = Fabricate(:order)
          xhr :put, :update, { id: order.id, order: { voyage: "black pearl" } }
          order.reload
          expect(order.voyage).to eq("black pearl")
        end
        it "redirects to the edit page" do 
          order = Fabricate(:order)
          xhr :put, :update, { id: order.id, order: { voyage: "black pearl" } }
          expect(response).to redirect_to edit_order_path(order)
        end

        it "sets the flash success message" do
          order = Fabricate(:order)
          xhr :put, :update, { id: order.id, order: { voyage: "black pearl" } }
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid input" do 
        it "renders the edit page"
        it "sets the flash error message"
      end
    end
  end
end