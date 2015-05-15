require 'spec_helper'

describe FumigationsController do
  describe "GET new" do 
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :new }
      end
    end
    context "with authenticated user" do
      before { set_current_user }
      let(:order) { Fabricate(:order) }

      it "sets @fumigation with a new instance variable" do 
        xhr :get, :new, order_id: order.id 
        assigns(:fumigation).should be_instance_of(Fumigation)
      end

      it "renders to the new path" do 
        xhr :get, :new, order_id: order.id
        expect(response).to render_template :new
      end
    end
  end

  describe "POST update" do 
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Fabricate(:variety).id }
      end
    end

    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do
        let(:fumigation) { Fabricate(:fumigation) }

        it "sets @fumigation with the updated fumigation instance" do 
          xhr :put, :update, { "id" => fumigation.id, "fumigation" => { notes: "ship the product correctly"}}
          fumigation.reload
          expect(fumigation.notes).to eq("ship the product correctly")
        end

        it "redirects to the edit page" do 
          xhr :put, :update, { "id" => fumigation.id, "fumigation" => { notes: "ship the product correctly"}}
          expect(response).to redirect_to edit_fumigation_path(fumigation) 
        end

        it "sets the flash success message" do 
          xhr :put, :update, { "id" => fumigation.id, "fumigation" => { notes: "ship the product correctly"}}
          expect(flash[:success]).to be_present
        end
      end
    end
  end

  describe "POST create" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, fumigation: Fabricate.attributes_for(:fumigation) }
      end
    end
    context "with authenticated user" do
      before { set_current_user }
      let(:order) { Fabricate(:order) }

      context "with valid input" do    
        it "redirects to the fumigation path" do
          xhr :post, :create, fumigation: { order_id: order.id, treatment: "1234", duration_of_exposure: "1hr" }
          @fumigation = Fumigation.first 
          expect(response).to redirect_to edit_fumigation_path(@fumigation)
        end
          
        it "creates a fumigation" do
          xhr :post, :create, fumigation: { order_id: order.id, treatment: "1234", duration_of_exposure: "1hr" }
          expect(Fumigation.count).to eq(1)
        end

        it "sets the flash success message" do
          xhr :post, :create, fumigation: { order_id: order.id, treatment: "1234", duration_of_exposure: "1hr" }
          expect(flash[:success]).to be_present
        end
      end
    end
  end
end