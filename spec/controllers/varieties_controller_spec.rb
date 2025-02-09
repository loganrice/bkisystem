require 'spec_helper'

describe VarietiesController do
  describe "GET index" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index }
      end
    end
    context "with authenticated user" do
      before { set_current_user } 

      it "sets the variety instance variable" do 
        carmel = Fabricate(:variety)
        nonpareil = Fabricate(:variety)
        xhr :get, :index
        expect(assigns(:varieties)).to include(carmel, nonpareil)
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
        let(:action) { xhr :get, :edit, id: Fabricate(:variety).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      it "sets @variety" do
        variety = Fabricate(:variety)
        xhr :get, :edit, id: variety.id 
        assigns(:variety).should == variety 
      end

      it "renders the edit template" do
        variety = Fabricate(:variety)
        xhr :get, :edit, id: variety.id
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

      it "sets @variety with a new instance variable" do 
        xhr :get, :new
        assigns(:variety).should be_instance_of(Variety)
      end
    end
  end

  describe "POST create" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, variety: Fabricate.attributes_for(:variety) }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do    
        it "redirects to the varieties path" do
          xhr :post, :create, variety: { name: "carmel" }
          expect(Variety.first.name).to eq("carmel")
        end
          
        it "creates a variety" do
          xhr :post, :create, variety: { name: "carmel" }
          expect(Variety.count).to eq(1)
        end

        it "sets the flash success message" do
          xhr :post, :create, variety: { name: "carmel" }
          expect(flash[:success]).to be_present
        end
      end
      context "with invalid input" do 
        it "renders the new template" do 
          xhr :post, :create, variety: { name: nil }
          expect(response).to render_template :new 
        end
        it "does not create a variety" do 
          xhr :post, :create, variety: { name: nil }
          expect(Variety.count).to eq(0)
        end
        it "sets the flash error message" do
          xhr :post, :create, variety: { name: nil }
          expect(flash[:error]).to be_present
        end
      end
    end
  end

  describe "PUT update" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Fabricate(:variety).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do
        let(:mission) { Fabricate(:variety) }

        it "sets @variety with the updated variety instance" do 
          xhr :put, :update, { "id" => mission.id, "variety" => { name: "mission"}}
          mission.reload
          expect(mission.name).to eq("mission")
        end

        it "redirects to the edit page" do 
          xhr :put, :update, { "id" => mission.id, "variety" => { name: "mission"}}
          expect(response).to redirect_to edit_variety_path(mission) 
        end

        it "sets the flash success message" do 
          xhr :put, :update, { "id" => mission.id, "variety" => { name: "mission"}}
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid input" do
        let(:mission) { Fabricate(:variety) }

        it "sets @variety with the updated variety instance" do
          mission = Variety.create(name: "test")
          mission.save
          xhr :put, :update, { "id" => mission.id, "variety" => {name: nil}}
          mission.reload
          expect(assigns(:variety)).to be_present
        end

        it "does not update the variety" do
          xhr :put, :update, { "id" => mission.id, "variety" => { name: nil } }
          mission.reload
          expect(mission.name).not_to eq(nil)
        end

        it "sets the flash error message" do 
          xhr :put, :update, { "id" => mission.id, "variety" => { name: nil } }
          expect(flash[:error]).to be_present
        end
      end
    end
  end
end