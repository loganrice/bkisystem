require 'spec_helper'

describe Contract do 
  it { should belong_to(:buyer) }
  it { should belong_to(:seller) }
  it { should have_one(:quote) }
  it { should have_many(:quote_line_items).through(:quote)}
  it { should have_many(:orders) }
  it { should accept_nested_attributes_for(:orders) }
  it { should validate_presence_of(:buyer)}
  it { should validate_presence_of(:seller)}

  it "creates a quote before savinging if one has not already been created" do 
    contract = Fabricate(:contract)
    expect(contract.quote).to be_instance_of(Quote)
  end

  describe "#order_container_sizes" do 
    it "returns a hash of each orders container sizes and the number of occurances" do 
      contract = Fabricate(:contract)
      order1 = Fabricate(:order, contract_id: contract.id)
      order2 = Fabricate(:order, contract_id: contract.id)
      order3 = Fabricate(:order, contract_id: contract.id)
      
      order1.update_attribute(:container_size, "40 FCL")
      order2.update_attribute(:container_size, "20 FCL")
      order3.update_attribute(:container_size, "40 FCL")

      expect(contract.order_container_sizes).to eq({"40 FCL"=>2, "20 FCL"=>1})
    end

  end

  describe "#total_pounds" do 
    it "returns a hash of each orders total weight in pounds" do 
      contract = Fabricate(:contract)
      order1 = Fabricate(:order, contract_id: contract.id)
      order2 = Fabricate(:order, contract_id: contract.id)
      
      order1_line1 = Fabricate(:order_line_item, order_id: order1.id, pack_weight_pounds: "500", pack_count: "10")
      order1_line2 = Fabricate(:order_line_item, order_id: order1.id, pack_weight_pounds: "500", pack_count: "10")
      order2_line1 = Fabricate(:order_line_item, order_id: order2.id, pack_weight_pounds: "100", pack_count: "5")

      expect(contract.total_pounds).to eq(BigDecimal("10500"))

    end

    it "returns a hash of the total weight in kilograms" do 

    end

  end
end

