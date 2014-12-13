require 'spec_helper'

describe UsersController do 
  describe "GET new" do 
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :new }
      end
    end
    context "with authenticated user" do
      before { set_current_user }

      it "sets @user" do 
        xhr :get, :new
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "renders the new template" do 
        xhr :get, :new
        expect(response).to render_template :new
      end
    end
  end
  describe "POST create" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, user: Fabricate.attributes_for(:user) }
      end
    end
    context "with authenticated user" do 
      context "with valid input" do 
        it "creates a new user" do
          set_current_user
          second_user_attributes = Fabricate.attributes_for(:user)
          xhr :post, :create, user: second_user_attributes
          expect(User.count).to eq(2)
        end

        it "redirects to the users path" do 
          set_current_user
          second_user_attributes = Fabricate.attributes_for(:user)
          xhr :post, :create, user: second_user_attributes
          expect(response).to redirect_to users_path
        end
      end
      context "with invalid input" do 
        it "does not create a user" do
          set_current_user
          second_user_attributes = Fabricate.attributes_for(:user, name: "")
          xhr :post, :create, user: second_user_attributes
          expect(User.count).to eq(1)
        end 
        it "renders the new template" do
          set_current_user
          second_user_attributes = Fabricate.attributes_for(:user, name: "")
          xhr :post, :create, user: second_user_attributes
          expect(response).to render_template :new
        end
      end
    end
  end

  describe "PUT edit" do 
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :edit, id: Fabricate(:user).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user } 

      it "sets @user" do 
        xhr :put, :edit, id: Fabricate(:user).id 
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "renders the edit template" do
        xhr :put, :edit, id: Fabricate(:user).id 
        expect(response).to render_template :edit
      end
    end
  end

  describe "PUT update" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :put, :update, id: Fabricate(:user).id }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  

      context "with valid context" do 
        it "updates users email" do
          karen = Fabricate(:user)
          xhr :put, :update, id: karen.id, user: { name: karen.name, password: karen.password, email: "karen@example.com" }
          karen.reload
          expect(karen.email).to eq("karen@example.com")
        end

        it "redirects to the users path" do
          karen = Fabricate(:user)
          xhr :put, :update, id: karen.id, user: { name: karen.name, password: karen.password, email: "karen@example.com" }        
          expect(response).to redirect_to users_path
        end
      end

      context "with invalid input" do 
        it "does not update users email" do 
          karen = Fabricate(:user, password: "karen@example.com")
          xhr :put, :update, id: karen.id, user: { email: "" }
          karen.reload
          expect(karen.email).to_not be_nil
        end
        it "renders the edit user template" do 
          karen = Fabricate(:user, password: "karen@example.com")
          xhr :put, :update, id: karen.id, user: { email: "" }
          expect(response).to render_template :edit        
        end
      end
    end
  end

  describe "GET index" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :index }
      end
    end
    context "with authenticated user" do
      before { set_current_user }  

      it "sets @users" do
        Fabricate(:user)
        xhr :get, :index
        expect(assigns(:users)).to be_present
      end
      it "renders the users index view" do
        xhr :get, :index
        expect(response).to render_template :index
      end
    end
  end
end