require 'spec_helper'

describe OriginsController do
  describe "GET index" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index }
      end
    end
    context "with authenticated user" do
      before { set_current_user } 

      it "sets the variety instance variable" do 
        usa = Fabricate(:origin)
        ca = Fabricate(:origin)
        xhr :get, :index
        expect(assigns(:origins)).to include(usa, ca)
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
        let(:action) { xhr :get, :edit, id: Fabricate(:origin).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      it "sets @origin" do
        origin = Fabricate(:origin)
        xhr :get, :edit, id: origin.id 
        assigns(:origin).should == origin 
      end

      it "renders the edit template" do
        origin = Fabricate(:origin)
        xhr :get, :edit, id: origin.id
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

      it "sets @origin with a new instance variable" do 
        xhr :get, :new
        assigns(:origin).should be_instance_of(Origin)
      end
    end
  end

  describe "POST create" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, origin: Fabricate.attributes_for(:origin) }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do    
        it "redirects to the origins path" do
          xhr :post, :create, origin: { name: "usa" }
          expect(Origin.first.name).to eq("usa")
        end
          
        it "creates a origin" do
          xhr :post, :create, origin: { name: "usa" }
          expect(Origin.count).to eq(1)
        end

        it "sets the flash success message" do
          xhr :post, :create, origin: { name: "usa" }
          expect(flash[:success]).to be_present
        end
      end
      context "with invalid input" do 
        it "renders the new template" do 
          xhr :post, :create, origin: { name: nil }
          expect(response).to render_template :new 
        end
        it "does not create a origin" do 
          xhr :post, :create, origin: { name: nil }
          expect(Origin.count).to eq(0)
        end
        it "sets the flash error message" do
          xhr :post, :create, origin: { name: nil }
          expect(flash[:error]).to be_present
        end
      end
    end
  end

  describe "PUT update" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Fabricate(:origin).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do
        let(:mission) { Fabricate(:origin) }

        it "sets @origin with the updated origin instance" do 
          xhr :put, :update, { "id" => mission.id, "origin" => { name: "mission"}}
          mission.reload
          expect(mission.name).to eq("mission")
        end

        it "redirects to the edit page" do 
          xhr :put, :update, { "id" => mission.id, "origin" => { name: "mission"}}
          expect(response).to redirect_to edit_origin_path(mission) 
        end

        it "sets the flash success message" do 
          xhr :put, :update, { "id" => mission.id, "origin" => { name: "mission"}}
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid input" do
        let(:mission) { Fabricate(:origin) }

        it "sets @variety with the updated variety instance" do
          mission = Origin.create(name: "test")
          mission.save
          xhr :put, :update, { "id" => mission.id, "origin" => {name: nil}}
          mission.reload
          expect(assigns(:origin)).to be_present
        end

        it "does not update the origin" do
          xhr :put, :update, { "id" => mission.id, "origin" => { name: nil } }
          mission.reload
          expect(mission.name).not_to eq(nil)
        end

        it "sets the flash error message" do 
          xhr :put, :update, { "id" => mission.id, "origin" => { name: nil } }
          expect(flash[:error]).to be_present
        end
      end
    end
  end
end