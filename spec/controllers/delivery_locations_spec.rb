require 'spec_helper'

describe DeliveryLocationsController do
  describe "GET index" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index }
      end
    end
    context "with authenticated user" do
      before { set_current_user } 

      it "sets the delivery_location instance variable" do 
        loc1 = DeliveryLocation.create(name: "location1", description: "location desc")
        loc2 = DeliveryLocation.create(name: "location2", description: "location desc")
        xhr :get, :index
        expect(assigns(:locations)).to include(loc1, loc2)
      end

      it "renders the index template" do 
        xhr :get, :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET edit' do 
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :edit, id: Fabricate(:delivery_location).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      it "sets @location" do
        location = Fabricate(:delivery_location)
        xhr :get, :edit, id: location.id 
        assigns(:location).should == location 
      end

      it "renders the edit template" do
        location = Fabricate(:delivery_location)
        xhr :get, :edit, id: location.id
        response.should render_template :edit
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

      it "sets @location with a new instance variable" do 
        xhr :get, :new
        assigns(:location).should be_instance_of(DeliveryLocation)
      end
    end
  end

  describe "POST create" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, delivery_location: Fabricate.attributes_for(:delivery_location) }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do    
        it "redirects to the delivery_locations path" do
          xhr :post, :create, delivery_location: { name: "carmel" }
          expect(DeliveryLocation.first.name).to eq("carmel")
        end
          
        it "creates a location" do
          xhr :post, :create, delivery_location: { name: "carmel" }
          expect(DeliveryLocation.count).to eq(1)
        end

        it "sets the flash success message" do
          xhr :post, :create, delivery_location: { name: "carmel" }
          expect(flash[:success]).to be_present
        end
      end
      context "with invalid input" do 
        it "renders the new template" do 
          xhr :post, :create, delivery_location: { name: nil }
          expect(response).to render_template :new 
        end
        it "does not create a location" do 
          xhr :post, :create, delivery_location: { name: nil }
          expect(DeliveryLocation.count).to eq(0)
        end
        it "sets the flash error message" do
          xhr :post, :create, delivery_location: { name: nil }
          expect(flash[:error]).to be_present
        end
      end
    end
  end

  describe "PUT update" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Fabricate(:delivery_location).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do
        let(:mission) { Fabricate(:delivery_location) }

        it "sets @location with the updated term instance" do 
          xhr :put, :update, { "id" => mission.id, "delivery_location" => { name: "mission"}}
          mission.reload
          expect(mission.name).to eq("mission")
        end

        it "redirects to the edit page" do 
          xhr :put, :update, { "id" => mission.id, "delivery_location" => { name: "mission"}}
          expect(response).to redirect_to edit_delivery_location_path(mission) 
        end

        it "sets the flash success message" do 
          xhr :put, :update, { "id" => mission.id, "delivery_location" => { name: "mission"}}
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid input" do
        let(:mission) { Fabricate(:delivery_location) }

        it "sets @locaiton with the updated term instance" do
          mission = DeliveryLocation.create(name: "test")
          mission.save
          xhr :put, :update, { "id" => mission.id, "delivery_location" => {name: nil}}
          mission.reload
          expect(assigns(:location)).to be_present
        end

        it "does not update the location" do
          xhr :put, :update, { "id" => mission.id, "delivery_location" => { name: nil } }
          mission.reload
          expect(mission.name).not_to eq(nil)
        end

        it "sets the flash error message" do 
          xhr :put, :update, { "id" => mission.id, "delivery_location" => { name: nil } }
          expect(flash[:error]).to be_present
        end
      end
    end
  end
end