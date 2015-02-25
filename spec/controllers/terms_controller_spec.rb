require 'spec_helper'

describe TermsController do
  describe "GET index" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index }
      end
    end
    context "with authenticated user" do
      before { set_current_user } 

      it "sets the term instance variable" do 
        term1 = Term.create(name: "term1", description: "Term1 desc")
        term2 = Term.create(name: "term2", description: "Term2 desc")
        xhr :get, :index
        expect(assigns(:terms)).to include(term1, term2)
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
        let(:action) { xhr :get, :edit, id: Fabricate(:term).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      it "sets @term" do
        term = Fabricate(:term)
        xhr :get, :edit, id: term.id 
        assigns(:term).should == term 
      end

      it "renders the edit template" do
        term = Fabricate(:term)
        xhr :get, :edit, id: term.id
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

      it "sets @term with a new instance variable" do 
        xhr :get, :new
        assigns(:term).should be_instance_of(Term)
      end
    end
  end

  describe "POST create" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, term: Fabricate.attributes_for(:term) }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do    
        it "redirects to the terms path" do
          xhr :post, :create, term: { name: "carmel" }
          expect(Term.first.name).to eq("carmel")
        end
          
        it "creates a term" do
          xhr :post, :create, term: { name: "carmel" }
          expect(Term.count).to eq(1)
        end

        it "sets the flash success message" do
          xhr :post, :create, term: { name: "carmel" }
          expect(flash[:success]).to be_present
        end
      end
      context "with invalid input" do 
        it "renders the new template" do 
          xhr :post, :create, term: { name: nil }
          expect(response).to render_template :new 
        end
        it "does not create a variety" do 
          xhr :post, :create, term: { name: nil }
          expect(Term.count).to eq(0)
        end
        it "sets the flash error message" do
          xhr :post, :create, term: { name: nil }
          expect(flash[:error]).to be_present
        end
      end
    end
  end

  describe "PUT update" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Fabricate(:term).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do
        let(:mission) { Fabricate(:term) }

        it "sets @term with the updated term instance" do 
          xhr :put, :update, { "id" => mission.id, "term" => { name: "mission"}}
          mission.reload
          expect(mission.name).to eq("mission")
        end

        it "redirects to the edit page" do 
          xhr :put, :update, { "id" => mission.id, "term" => { name: "mission"}}
          expect(response).to redirect_to edit_term_path(mission) 
        end

        it "sets the flash success message" do 
          xhr :put, :update, { "id" => mission.id, "term" => { name: "mission"}}
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid input" do
        let(:mission) { Fabricate(:term) }

        it "sets @term with the updated term instance" do
          mission = Term.create(name: "test")
          mission.save
          xhr :put, :update, { "id" => mission.id, "term" => {name: nil}}
          mission.reload
          expect(assigns(:term)).to be_present
        end

        it "does not update the term" do
          xhr :put, :update, { "id" => mission.id, "term" => { name: nil } }
          mission.reload
          expect(mission.name).not_to eq(nil)
        end

        it "sets the flash error message" do 
          xhr :put, :update, { "id" => mission.id, "term" => { name: nil } }
          expect(flash[:error]).to be_present
        end
      end
    end
  end
end