require 'spec_helper'

describe RemarksController do
  describe "GET index" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index }
      end
    end
    context "with authenticated user" do
      before { set_current_user } 

      it "sets the term instance variable" do 
        term1 = Remark.create(name: "term1", description: "Term1 desc")
        term2 = Remark.create(name: "term2", description: "Term2 desc")
        xhr :get, :index
        expect(assigns(:remarks)).to include(term1, term2)
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
        let(:action) { xhr :get, :edit, id: Fabricate(:remark).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      it "sets @remark" do
        remark = Fabricate(:remark)
        xhr :get, :edit, id: remark.id 
        assigns(:remark).should == remark 
      end

      it "renders the edit template" do
        remark = Fabricate(:remark)
        xhr :get, :edit, id: remark.id
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

      it "sets @remark with a new instance variable" do 
        xhr :get, :new
        assigns(:remark).should be_instance_of(Remark)
      end
    end
  end

  describe "POST create" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, remark: Fabricate.attributes_for(:remark) }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do    
        it "redirects to the terms path" do
          xhr :post, :create, remark: { name: "carmel" }
          expect(Remark.first.name).to eq("carmel")
        end
          
        it "creates a remark" do
          xhr :post, :create, remark: { name: "carmel" }
          expect(Remark.count).to eq(1)
        end

        it "sets the flash success message" do
          xhr :post, :create, remark: { name: "carmel" }
          expect(flash[:success]).to be_present
        end
      end
      context "with invalid input" do 
        it "renders the new template" do 
          xhr :post, :create, remark: { name: nil }
          expect(response).to render_template :new 
        end
        it "does not create a remark" do 
          xhr :post, :create, remark: { name: nil }
          expect(Term.count).to eq(0)
        end
        it "sets the flash error message" do
          xhr :post, :create, remark: { name: nil }
          expect(flash[:error]).to be_present
        end
      end
    end
  end

  describe "PUT update" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Fabricate(:remark).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do
        let(:mission) { Fabricate(:remark) }

        it "sets @remark with the updated term instance" do 
          xhr :put, :update, { "id" => mission.id, "remark" => { name: "mission"}}
          mission.reload
          expect(mission.name).to eq("mission")
        end

        it "redirects to the edit page" do 
          xhr :put, :update, { "id" => mission.id, "remark" => { name: "mission"}}
          expect(response).to redirect_to edit_remark_path(mission) 
        end

        it "sets the flash success message" do 
          xhr :put, :update, { "id" => mission.id, "remark" => { name: "mission"}}
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid input" do
        let(:mission) { Fabricate(:remark) }

        it "sets @remark with the updated remark instance" do
          mission = Remark.create(name: "test")
          mission.save
          xhr :put, :update, { "id" => mission.id, "remark" => {name: nil}}
          mission.reload
          expect(assigns(:remark)).to be_present
        end

        it "does not update the remark" do
          xhr :put, :update, { "id" => mission.id, "remark" => { name: nil } }
          mission.reload
          expect(mission.name).not_to eq(nil)
        end

        it "sets the flash error message" do 
          xhr :put, :update, { "id" => mission.id, "remark" => { name: nil } }
          expect(flash[:error]).to be_present
        end
      end
    end
  end
end