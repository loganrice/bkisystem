require 'spec_helper'

describe ContractDoc do 
  before(:each) do 
    @contract = Fabricate(:contract)
    order1 = Fabricate(:order, contract_id: @contract.id, container_size: "40FCL")
    order2 = Fabricate(:order, contract_id: @contract.id, container_size: "20FCL")
    buyer_address = Fabricate(:address)
    seller_address = Fabricate(:address)
    @contract.seller.addresses << seller_address
    @contract.buyer.addresses << buyer_address 

    size_indicator = ItemSizeIndicator.create(name: "AOL")
    nonpareil = Variety.create(name: "Nonpareil")
    almonds = Commodity.create(name: "Almonds")
    grade = Grade.create(name: "US Extra No. 1")
    size = Size.create(name: "22/24")
    origin = Origin.create(name: "California")
    shelled = Shell.create(name: "Shelled")
    lbs = Weight.create(weight_unit_of_measure: "Lbs")
    carton = PackType.create(name: "carton")
    item1 = Item.create(name: "Nonpariel Almonds US Extra No. 1 22/24", variety_id: nonpareil.id,
                          commodity_id: almonds.id, shell_id: shelled.id, origin_id: origin.id, grade_id: grade.id, size_id: size.id)

    order1_line1 = Fabricate(:order_line_item, item_id: item1.id, order_id: order1.id, season: "2014", pack_weight_pounds: "500", pack_count: "10", item_size_indicator_id: size_indicator.id, weight_id: lbs.id, pack_type_id: carton.id, price_cents: 100)
    order1_line2 = Fabricate(:order_line_item, item_id: item1.id, order_id: order2.id, season: "2014", pack_weight_pounds: "500", pack_count: "10", item_size_indicator_id: size_indicator.id, weight_id: lbs.id, pack_type_id: carton.id, price_cents: 100)
    order2_line1 = Fabricate(:order_line_item, item_id: item1.id, order_id: order1.id, season: "2015", pack_weight_pounds: "100", pack_count: "5", item_size_indicator_id: size_indicator.id, weight_id: lbs.id, pack_type_id: carton.id, price_cents: 100)

    @contract.reload
  end

  describe "#commodity_season" do
    it "returns all of the uniq origin commodities and seasons" do 
      report = ContractDoc.new(@contract)
      season_2014 = "California Almonds - 2014"
      season_2015 = "California Almonds - 2015"
      expect(report.commodity_season).to match(season_2014)
      expect(report.commodity_season).to match(season_2015)

    end
  end

  describe "#documents" do 
    it "returns all of the uniq documents" do 
      doc1 = Document.create(name: "doc1")
      doc2 = Document.create(name: "doc2")
      @contract.orders.first.documents << doc1
      @contract.orders.first.documents << doc2
      report = ContractDoc.new(@contract)
      expect(report.documents).to match(doc1.name)
      expect(report.documents).to match(doc2.name)

    end
  end

  describe "#quantity" do 
    it "returns a contracts orders container sizes and the number of occurances" do
      report = ContractDoc.new(@contract) 
      expect(report.quantity).to eq("2 X 40FCL")
      @contract.orders.last.container_size = "20FCL"
      expect(report.quantity).to eq("1 X 40FCL, and 1 X 20FCL")
    end
  end

  describe "#weight" do 
    it "returns each contract's orders total weight in pounds" do 
      report = ContractDoc.new(@contract)
      expect(report.weight).to eq("About 10,500 Lbs. in 2 shipments")
    end
  end

  describe "#quality" do 
    it "lists the types of items included in each order" do 
      report = ContractDoc.new(@contract)
      expect(report.quality).to eq("Nonpareil Almonds US Extra No. 1 22/24 AOL")
    end

    it "does not include attributes that are NA" do 
      na = Commodity.create(name: "NA")
      @contract.orders.first.order_line_items.first.item.update_attributes(commodity_id: na.id)
      report = ContractDoc.new(@contract)
      expect(report.quality).to_not match(/NA/)
    end

    it "does not include attributes that are Shelled" do 
      shelled = Shell.create(name: "Shelled")
      @contract.orders.first.order_line_items.first.item.update_attributes(shell_id: shelled.id)
      report = ContractDoc.new(@contract)
      expect(report.quality).to_not match(/Shelled/)
    end
  end

  describe "#packaging_message" do
    it "lists the packaging details included in each order" do 
      require 'pry';
      report = ContractDoc.new(@contract)
      items = "5 X 100.0 Lbs carton in 1 shipment, 20 X 500.0 Lbs carton in 2 shipments"
      expect(report.packaging_message).to match(items)
    end
  end

  describe "#price" do 
    it "returns the price message" do 
      report = ContractDoc.new(@contract)
      expect(report.price).to include("US Extra No. 1 22/24 AOL $1.00/Lbs FAS Oakland")
    end
  end
end