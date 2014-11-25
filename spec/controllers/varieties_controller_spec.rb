require 'spec_helper'

describe VarietiesController do 
  describe "GET index" do 
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

  describe 'GET edit' do 
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

  describe "GET new" do 
    it "sets @variety with a new instance variable" do 
      xhr :get, :new
      assigns(:variety).should be_instance_of(Variety)
    end
  end

  describe "PUT update" do 
    let(:mission) { Fabricate(:variety) }

    context "with valid input" do 
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
      it "sets @variety with the updated variety instance" do 
        xhr :put, :update, { "id" => mission.id, "variety" => { name: nil } }
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