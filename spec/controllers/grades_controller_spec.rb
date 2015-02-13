require 'spec_helper'

describe GradesController do
  describe "GET index" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index }
      end
    end
    context "with authenticated user" do
      before { set_current_user } 

      it "sets the grade instance variable" do 
        ssr = Fabricate(:grade)
        fancy = Fabricate(:grade)
        xhr :get, :index
        expect(assigns(:grades)).to include(ssr, fancy)

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
        let(:action) { xhr :get, :edit, id: Fabricate(:grade).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      it "sets @grade" do
        grade = Fabricate(:grade)
        xhr :get, :edit, id: grade.id 
        assigns(:grade).should == grade 
      end

      it "renders the edit template" do
        grade = Fabricate(:grade)
        xhr :get, :edit, id: grade.id
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

      it "sets @grade with a new instance variable" do 
        xhr :get, :new
        assigns(:grade).should be_instance_of(Grade)
      end
    end
  end

  describe "POST create" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, grade: Fabricate.attributes_for(:grade) }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do    
        it "redirects to the grades path" do
          xhr :post, :create, grade: { name: "fancy" }
          expect(Grade.first.name).to eq("fancy")
        end
          
        it "creates a grade" do
          xhr :post, :create, grade: { name: "fancy" }
          expect(Grade.count).to eq(1)
        end

        it "sets the flash success message" do
          xhr :post, :create, grade: { name: "carmel" }
          expect(flash[:success]).to be_present
        end
      end
      context "with invalid input" do 
        it "renders the new template" do 
          xhr :post, :create, grade: { name: nil }
          expect(response).to render_template :new 
        end
        it "does not create a grade" do 
          xhr :post, :create, grade: { name: nil }
          expect(Grade.count).to eq(0)
        end
        it "sets the flash error message" do
          xhr :post, :create, grade: { name: nil }
          expect(flash[:error]).to be_present
        end
      end
    end
  end

  describe "PUT update" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Fabricate(:grade).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      context "with valid input" do
        let(:fancy) { Fabricate(:grade) }

        it "sets @grade with the updated grade instance" do 
          xhr :put, :update, { "id" => fancy.id, "grade" => { name: "fancy"}}
          fancy.reload
          expect(fancy.name).to eq("fancy")
        end

        it "redirects to the edit page" do 
          xhr :put, :update, { "id" => fancy.id, "grade" => { name: "fancy"}}
          expect(response).to redirect_to edit_grade_path(fancy) 
        end

        it "sets the flash success message" do 
          xhr :put, :update, { "id" => fancy.id, "grade" => { name: "fancy"}}
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid input" do
        let(:fancy) { Fabricate(:grade) }

        it "sets @grade with the updated grade instance" do
          grade = Grade.create(name: "test")
          grade.save
          xhr :put, :update, { "id" => grade.id, "grade" => {name: nil}}
          grade.reload
          expect(assigns(:grade)).to be_present
        end

        it "does not update the grade" do
          xhr :put, :update, { "id" => fancy.id, "grade" => { name: nil } }
          fancy.reload
          expect(fancy.name).not_to eq(nil)
        end

        it "sets the flash error message" do 
          xhr :put, :update, { "id" => fancy.id, "grade" => { name: nil } }
          expect(flash[:error]).to be_present
        end
      end
    end
  end
end