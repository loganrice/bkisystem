require 'spec_helper'

describe ContractReport do 
  let!(:contract) { set_up_contract }

  def set_up_contract
    contract = Fabricate(:contract)
    order1 = Fabricate(:order, contract_id: contract.id, container_size: "40FCL")
    order2 = Fabricate(:order, contract_id: contract.id, container_size: "40FCL")
    
    size_indicator = ItemSizeIndicator.create(name: "AOL")
    nonpareil = Variety.create(name: "Nonpareil")
    almonds = Commodity.create(name: "Almonds")
    grade = Grade.create(name: "US Extra No. 1")
    size = Size.create(name: "22/24")
    lbs = Weight.create(weight_unit_of_measure: "Lbs")
    carton = PackType.create(name: "carton")
    item1 = Item.create(name: "Nonpariel Almonds US Extra No. 1 22/24", variety_id: nonpareil.id,
                          commodity_id: almonds.id, grade_id: grade.id, size_id: size.id)

    order1_line1 = Fabricate(:order_line_item, item_id: item1.id, order_id: order1.id, pack_weight_pounds: "500", pack_count: "10", item_size_indicator_id: size_indicator.id, weight_id: lbs.id, pack_type_id: carton.id)
    order1_line2 = Fabricate(:order_line_item, item_id: item1.id, order_id: order2.id, pack_weight_pounds: "500", pack_count: "10", item_size_indicator_id: size_indicator.id, weight_id: lbs.id, pack_type_id: carton.id)
    order2_line1 = Fabricate(:order_line_item, item_id: item1.id, order_id: order1.id, pack_weight_pounds: "100", pack_count: "5", item_size_indicator_id: size_indicator.id, weight_id: lbs.id, pack_type_id: carton.id)

    return contract
  end

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
      expect(report.quality).to eq("Nonpareil Almonds US Extra No. 1 22/24 AOL")
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