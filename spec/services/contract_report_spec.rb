require 'spec_helper'

describe ContractReport do 
  let!(:contract) { set_up_contract }



  describe "#quantity" do 
    it "returns a contracts orders container sizes and the number of occurances" do
      order3 = Fabricate(:order, contract_id: contract.id)
      order3.update_attribute(:container_size, "20FCL")
      report = ContractReport.new(contract) 
      expect(report.quantity).to eq("2 X 40FCL, and 1 X 20FCL")
    end
  end

  describe "#weight" do 
    it "returns each contract's orders total weight in pounds" do 
      report = ContractReport.new(contract)
      expect(report.weight).to eq("About 10,500 Lbs. in 2 shipments")
    end

  end

  describe "#quality" do 
    it "lists the types of items included in each order" do 
      report = ContractReport.new(contract)
      expect(report.quality).to eq(["Nonpareil Almonds US Extra No. 1 22/24 AOL"])
    end
  end

  describe "#packaging_message" do
    it "lists the packaging details included in each order" do 
      report = ContractReport.new(contract)
      items = ["20 X 500.0 Lbs carton in 2 shipments", "5 X 100.0 Lbs carton in 1 shipment"]
      expect(report.packaging_message).to match_array(items)
    end
  end
end