require 'spec_helper'

describe ContractsController do 
  describe "GET index" do 
    it "sets @contracts" do 
      contract1 = Fabricate(:contract)
      contract2 = Fabricate(:contract)
      contract3 = Fabricate(:contract)
      xhr :get, :index
      expect(assigns(:contracts)).to match_array([contract1, contract2, contract3])
    end
  end
  describe "GET new" do 
    it "sets @contract with a new instance variable" do 
      xhr :get, :new
      expect(assigns(:contract)).to be_instance_of(Contract)
    end
  end
end