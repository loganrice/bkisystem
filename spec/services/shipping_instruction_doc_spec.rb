require 'spec_helper'

describe ShippingInstructionDoc do 
  let!(:order) do 
    contract = set_up_contract
    contract.orders.first
  end

  describe "#ship_date" do 
    it "returns the ship_date" do
      order.update_attributes(ship_date: Date.new(2014, 1, 1))
      report = ShippingInstructionDoc.new(order)
      expect(report.ship_date).to eq("01/01/2014")
    end
  end

  describe "#seller_contract" do 
    it "returns the seller contract number" do
      seller_contract = order.contract.seller_contract
      report = ShippingInstructionDoc.new(order)
      expect(report.seller_contract).to eq(seller_contract)
    end
  end

  describe "#load_number" do 
    it "returns the row_on_contract" do
      load = order.row_on_contract.to_s
      report = ShippingInstructionDoc.new(order)
      expect(report.load_number).to eq(load)
    end
  end

  describe "#buyer_contract" do 
    it "returns the buyer's contract number" do
      buyer_contract = order.contract.buyer_contract
      report = ShippingInstructionDoc.new(order)
      expect(report.buyer_contract).to eq(buyer_contract)
    end
  end

  describe "#seller_name" do 
    it "returns the seller's name" do
      name = order.contract.seller.name
      report = ShippingInstructionDoc.new(order)
      expect(report.seller_name).to eq(name)
    end
  end

  describe "#seller_address" do 
    it "returns the first address associated with the seller" do 
      report = ShippingInstructionDoc.new(order)
      address = order.contract.seller.addresses.first
      expect(report.seller_address).to eq(address)
    end
  end

  describe "#buyer_address" do 
    it "returns the first address associated with the buyer" do 
      report = ShippingInstructionDoc.new(order)
      address = order.contract.buyer.addresses.first
      expect(report.buyer_address).to eq(address)
    end
  end

  describe "#buyer_name" do 
    it "returns the buyer's name" do
      name = order.contract.buyer.name
      report = ShippingInstructionDoc.new(order)
      expect(report.buyer_name).to eq(name)
    end
  end

  describe "#consignee" do 
    it "returns name of consignee" do 
      consignee = order.consignee 
      report = ShippingInstructionDoc.new(order)
      expect(report.consignee).to eq(consignee)
    end
  end

  describe "#line1" do 
    it "returns line1 of the consignee's address" do 
      line1 = order.line1 
      report = ShippingInstructionDoc.new(order)
      expect(report.line1).to eq(line1)
    end
  end

  describe "#city" do 
    it "returns city of the consignee's address" do 
      city = "#{order.city}"
      report = ShippingInstructionDoc.new(order)
      expect(report.city).to eq(city)
    end
  end

  describe "#state" do 
    it "returns state of the consignee's address" do 
      state = order.state 
      report = ShippingInstructionDoc.new(order)
      expect(report.state).to eq(state)
    end
  end

  describe "#zip" do 
    it "returns zip of the consignee's address" do 
      zip = order.zip 
      report = ShippingInstructionDoc.new(order)
      expect(report.zip).to eq(zip)
    end
  end

  describe "#container" do 
    it "returns the order container size" do 
      container = order.container_size
      report = ShippingInstructionDoc.new(order)
      expect(report.container).to eq(container)
    end
  end

  describe "#load_count" do 
    it "returns the number of orders(aka loads) associated with the contract" do 
      count = order.contract.orders.count 
      report = ShippingInstructionDoc.new(order)
      expect(report.load_count).to eq(count.to_s)
    end
  end

  describe "#pack_count" do 
    it "returns the pack count of the first item on the order" do 
      count = order.contract.orders.count
      report = ShippingInstructionDoc.new(order)
      expect(report.load_count).to eq(count.to_s)
    end
  end

  describe "#shipping_company" do 
    it "returns the shipping company on the order" do 
      company = order.shipping_company
      report = ShippingInstructionDoc.new(order)
      expect(report.shipping_company).to eq(company)
    end
  end

  describe "#vessel" do 
    it "returns the vessel on the order" do 
      vessel = order.vessel
      report = ShippingInstructionDoc.new(order)
      expect(report.vessel).to eq(vessel)
    end
  end

  describe "#voyage" do 
    it "returns the voyage on the order" do 
      voyage = order.voyage
      report = ShippingInstructionDoc.new(order)
      expect(report.voyage).to eq(voyage)
    end
  end

  describe "#booking_number" do 
    it "returns the booking number on the order" do 
      booking = order.booking_number
      report = ShippingInstructionDoc.new(order)
      expect(report.booking_number).to eq(booking)
    end
  end

  describe "#port" do 
    it "returns the port of discharge on the order" do 
      port = order.port_of_discharge
      report = ShippingInstructionDoc.new(order)
      expect(report.port).to eq(port)
    end
  end

  describe "#booking_number" do 
    it "returns the booking number on the order" do 
      booking = order.booking_number
      report = ShippingInstructionDoc.new(order)
      expect(report.booking_number).to eq(booking)
    end
  end

  describe "#last_received_date" do 
    it "returns the last_received_date on the order" do 
      date = order.last_received_date.strftime("%m/%d/%Y")
      report = ShippingInstructionDoc.new(order)
      expect(report.last_received_date).to eq(date)
    end
  end

  describe "#doc_cut_off" do 
    it "returns the doc_cut_off date on the order" do 
      date = order.doc_cut_off.strftime("%m/%d/%Y")
      report = ShippingInstructionDoc.new(order)
      expect(report.doc_cut_off).to eq(date)
    end
  end

  describe "#estimated_arrival_date" do 
    it "returns the estimated_arrival_date date on the order" do 
      date = order.estimated_arrival_date.strftime("%m/%d/%Y")
      report = ShippingInstructionDoc.new(order)
      expect(report.estimated_arrival_date).to eq(date)
    end
  end

  describe "#ship_pick_up" do 
    it "returns the ship pick up on the order" do 
      note = order.ship_pick_up = "Pick Up ASAP"
      report = ShippingInstructionDoc.new(order)
      expect(report.ship_pick_up).to eq(note)
    end
  end

  describe "#ship_delivery" do 
    it "returns the ship_delivery up on the order" do 
      note = order.ship_delivery
      report = ShippingInstructionDoc.new(order)
      expect(report.ship_delivery).to eq(note.to_s)
    end
  end

  describe "#documents" do 
    it "returns the documents on the order" do 
      doc1 = Document.create(name: "Special Report")
      doc2 = Document.create(name: "Quality Inspection")
      order.documents << doc1
      order.documents << doc2

      documents = order.documents.map { |document| document.name }.join(", ")
      report = ShippingInstructionDoc.new(order)
      expect(report.documents).to include("Special Report")
      expect(report.documents).to include("Quality Inspection")
    end
  end

  describe "#mail_to" do 
    it "returns the name of the mail_to on the order" do 
      name = order.mail_to.name
      report = ShippingInstructionDoc.new(order)
      expect(report.mail_to).to eq(name)
    end
  end


  describe "#ensure_string" do 
    context "with valid address" do
      before(:all) do
        @address = Fabricate(:address)
        contract = set_up_contract
        order = contract.orders.first
        order.mail_to.addresses << @address
        @report = ShippingInstructionDoc.new(order)
      end

      let(:report) { @report }

      it "returns line1" do
        line1 = report.ensure_string(report.mail_to_address, :line1)
        expect(line1).to eq(@address.line1)
      end

      it "returns the city" do 
        city = report.ensure_string(report.mail_to_address, :city)
        expect(city).to eq(@address.city)
      end

      it "returns the state" do 
        state = report.ensure_string(report.mail_to_address, :state)
        expect(state).to eq(@address.state)
      end

      it "returns the zip" do 
        zip = report.ensure_string(report.mail_to_address, :zip)
        expect(zip).to eq(@address.zip)
      end
    end
  end


  describe "#shipping_instructions" do 
    it "returns order's shipping instructions" do
      instructions = order.shipping_instructions = "Attach PO"
      report = ShippingInstructionDoc.new(order)
      expect(report.shipping_instructions).to eq(instructions)
    end
  end

  describe "#origin" do 
    it "returns the origin of the first item on the order" do 
      origin = order.order_line_items.first.item.origin.name
      report = ShippingInstructionDoc.new(order)
      expect(report.origin).to eq(origin)
    end
  end

  describe "#commodity" do 
    it "returns the commodity of the first item on the order" do 
      commodity = order.order_line_items.first.item.commodity.name
      report = ShippingInstructionDoc.new(order)
      expect(report.commodity).to eq(commodity)
    end
  end

  describe "#get_item_properties" do 
    let!(:order) { Fabricate(:order)}
    before(:each) do 
      certificate = CertificateOfOrigin.create(order_id: order.id, forwarding_agent: "Bob")
      california = Origin.create(name: "california")
      almonds = Commodity.create(name: "almonds")
      item = Fabricate(:item, commodity_id: almonds.id, origin_id: california.id)
      line_item1 = OrderLineItem.create(order_id: order.id, item_id: item.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 447)
      line_item2 = OrderLineItem.create(order_id: order.id, item_id: item.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 433)
    end


    it "includes the item's pack_count" do
      line_item = order.order_line_items.first
      line_item.pack_count = 880
      report = CertificateOfOriginDoc.new(order)
      expect(report.get_item_properties(line_item)[:pack_count]).to eq(880) 
    end

    it "contains the item pack weight pounds" do
      line_item = order.order_line_items.first
      line_item.pack_weight_pounds = 50
      report = CertificateOfOriginDoc.new(order)
      expect(report.get_item_properties(line_item)[:pack_weight]).to eq(50) 
    end

    it "contains the item origin" do 
      line_item = order.order_line_items.first
      line_item.item.origin.name = "california"
      report = CertificateOfOriginDoc.new(order)
      expect(report.get_item_properties(line_item)[:origin]).to eq("california") 
    end 
    it "contains the item commodity" do 
      line_item = order.order_line_items.first
      line_item.item.commodity.name = "almonds"
      report = CertificateOfOriginDoc.new(order)
      expect(report.get_item_properties(line_item)[:commodity]).to eq("almonds") 
    end
  end

  describe "#uniq_items" do

    before(:each) do 
      order2 = Fabricate(:order)
      bags = PackType.create(name: "bags")
      california = Origin.create(name: "california")
      almonds = Commodity.create(name: "almonds")
      item = Fabricate(:item)
      item.commodity = almonds
      item.origin = california
      item.save
      order2.order_line_items.delete_all
      line_item1 = OrderLineItem.create(order_id: order2.id, item_id: item.id, pack_type_id: bags.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 447)
      line_item2 = OrderLineItem.create(order_id: order2.id, item_id: item.id, pack_type_id: bags.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 433)
    end

    it "only includes each @item once" do 
      boxes = PackType.create(name: "boxes")
      order = Order.last
      item = Item.first
      line_item2 = OrderLineItem.create(order_id: order.id, item_id: item.id, pack_type_id: boxes.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 433)
      report = ShippingInstructionDoc.new(order)
      expect(report.uniq_items.count).to eq(2)
    end

    it "adds the pack_count to items with the same name" do
      order = Order.last
      report = ShippingInstructionDoc.new(order)
      expect(order.order_line_items.count).to eq(2)
      expect(report.uniq_items.count).to eq(1)
    end

  end
end
