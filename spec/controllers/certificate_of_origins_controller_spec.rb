require 'spec_helper'

describe CertificateOfOriginsController do
  describe "GET new" do 
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :get, :new }
      end
    end
    context "with authenticated user" do
      before { set_current_user }
      let(:order) { Fabricate(:order) }

      it "sets @certificate_of_origin with a new instance variable" do 
        require 'pry';
        xhr :get, :new, order_id: order.id 
        assigns(:certificate_of_origin).should be_instance_of(CertificateOfOrigin)
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
        let(:certificate) { Fabricate(:certificate_of_origin) }

        it "sets @certificate_of_origin with the updated certificate_of_origin instance" do 
          xhr :put, :update, { "id" => certificate.id, "certificate_of_origin" => { routing_instructions: "ship the product correctly"}}
          certificate.reload
          expect(certificate.routing_instructions).to eq("ship the product correctly")
        end

        it "redirects to the edit page" do 
          xhr :put, :update, { "id" => certificate.id, "certificate_of_origin" => { routing_instructions: "ship the product correctly"}}
          expect(response).to redirect_to edit_certificate_of_origin_path(certificate) 
        end

        it "sets the flash success message" do 
          xhr :put, :update, { "id" => certificate.id, "certificate_of_origin" => { routing_instructions: "ship the product correctly"}}
          expect(flash[:success]).to be_present
        end
      end

      context "with invalid input" do
        let(:certificate) { Fabricate(:certificate_of_origin) }

        it "does not update the certificate_of_origin" do
          xhr :put, :update, { "id" => certificate.id, "certificate_of_origin" => { forwarding_agent: nil}}
          certificate.reload
          expect(certificate.forwarding_agent).not_to eq(nil)
        end

      end
    end
  end

  describe "POST create" do
    context "with unauthenticated user" do 
      it_behaves_like "require_sign_in" do
        let(:action) { xhr :post, :create, certificate_of_origin: Fabricate.attributes_for(:certificate_of_origin) }
      end
    end
    context "with authenticated user" do
      before { set_current_user }
      let(:order) { Fabricate(:order) }

      context "with valid input" do    
        it "redirects to the certificate_of_origin path" do
          xhr :post, :create, certificate_of_origin: { order_id: order.id, hs_code: "1234", forwarding_agent: "Sarah" }
          @certificate = CertificateOfOrigin.first 
          expect(response).to redirect_to edit_certificate_of_origin_path(@certificate)
        end
          
        it "creates a certificate of origin" do
          xhr :post, :create, certificate_of_origin: { order_id: order.id, hs_code: "1234", forwarding_agent: "Sarah"}
          expect(CertificateOfOrigin.count).to eq(1)
        end

        it "sets the flash success message" do
          xhr :post, :create, certificate_of_origin: { order_id: order.id, hs_code: "1234", forwarding_agent: "Sarah"}
          expect(flash[:success]).to be_present
        end
      end
      context "with invalid input" do 
        it "renders the new template" do 
          xhr :post, :create, certificate_of_origin: { order_id: nil, hs_code: "1234" }
          expect(response).to render_template :new 
        end
        it "does not create a certificate_of_origin" do 
          xhr :post, :create, certificate_of_origin: { order_id: nil, hs_code: "1234" }
          expect(CertificateOfOrigin.count).to eq(0)
        end
        it "sets the flash error message" do
          xhr :post, :create, certificate_of_origin: { order_id: nil, hs_code: "1234"}
          expect(flash[:error]).to be_present
        end
      end
    end
  end
end