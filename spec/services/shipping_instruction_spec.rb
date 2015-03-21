require 'spec_helper'

describe ShippingInstruction do 
  let!(:order) do 
    contract = set_up_contract
    contract.orders.first
  end

  describe "#ship_date" do 
    it "returns the ship_date" do
      order.update_attributes(ship_date: Date.new(2014, 1, 1))
      report = ShippingInstruction.new(order)
      expect(report.ship_date).to eq("2014-01-01")
    end
  end

  describe "#seller_contract" do 
    it "returns the seller contract number" do
      seller_contract = order.contract.seller_contract
      report = ShippingInstruction.new(order)
      expect(report.seller_contract).to eq(seller_contract)
    end
  end

  describe "#load_number" do 
    it "returns the row_on_contract" do
      load = order.row_on_contract.to_s
      report = ShippingInstruction.new(order)
      expect(report.load_number).to eq(load)
    end
  end

  describe "#buyer_contract" do 
    it "returns the buyer's contract number" do
      buyer_contract = order.contract.buyer_contract
      report = ShippingInstruction.new(order)
      expect(report.buyer_contract).to eq(buyer_contract)
    end
  end

  describe "#seller_name" do 
    it "returns the seller's name" do
      name = order.contract.seller.name
      report = ShippingInstruction.new(order)
      expect(report.seller_name).to eq(name)
    end
  end

  describe "#seller_address_line1" do 
    it "returns line 1 of the first address associated with the seller" do 
      line1 = order.contract.seller.addresses.first.line1 
      report = ShippingInstruction.new(order)
      expect(report.seller_address_line1).to eq(line1)
    end
  end

  describe "#seller_address_city" do 
    it "returns city of the first address associated with the seller" do 
      city = "#{order.contract.seller.addresses.first.city}," 
      report = ShippingInstruction.new(order)
      expect(report.seller_address_city).to eq(city)
    end
  end

  describe "#seller_address_state" do 
    it "returns state of the first address associated with the seller" do 
      state = order.contract.seller.addresses.first.state 
      report = ShippingInstruction.new(order)
      expect(report.seller_address_state).to eq(state)
    end
  end

  describe "#seller_address_zip" do 
    it "returns zip of the first address associated with the seller" do 
      zip = order.contract.seller.addresses.first.zip 
      report = ShippingInstruction.new(order)
      expect(report.seller_address_zip).to eq(zip)
    end
  end

  describe "#buyer_name" do 
    it "returns the buyer's name" do
      name = order.contract.buyer.name
      report = ShippingInstruction.new(order)
      expect(report.buyer_name).to eq(name)
    end
  end

  describe "#buyer_address_line1" do 
    it "returns the buyer's first address line1" do
      line1 = order.contract.buyer.addresses.first.line1
      report = ShippingInstruction.new(order)
      expect(report.buyer_address_line1).to eq(line1)
    end
  end

  describe "#buyer_address_city" do 
    it "returns city of the first address associated with the buyer" do 
      city = "#{order.contract.buyer.addresses.first.city},"
      report = ShippingInstruction.new(order)
      expect(report.buyer_address_city).to eq(city)
    end
  end

  describe "#buyer_address_state" do 
    it "returns state of the first address associated with the buyer" do 
      state = order.contract.buyer.addresses.first.state 
      report = ShippingInstruction.new(order)
      expect(report.buyer_address_state).to eq(state)
    end
  end

  describe "#buyer_address_zip" do 
    it "returns zip of the first address associated with the buyer" do 
      zip = order.contract.buyer.addresses.first.zip 
      report = ShippingInstruction.new(order)
      expect(report.buyer_address_zip).to eq(zip)
    end
  end

  describe "#consignee" do 
    it "returns name of consignee" do 
      consignee = order.consignee 
      report = ShippingInstruction.new(order)
      expect(report.consignee).to eq(consignee)
    end
  end

  describe "#line1" do 
    it "returns line1 of the consignee's address" do 
      line1 = order.line1 
      report = ShippingInstruction.new(order)
      expect(report.line1).to eq(line1)
    end
  end

  describe "#city" do 
    it "returns city of the consignee's address" do 
      city = "#{order.city},"
      report = ShippingInstruction.new(order)
      expect(report.city).to eq(city)
    end
  end

  describe "#state" do 
    it "returns state of the consignee's address" do 
      state = order.state 
      report = ShippingInstruction.new(order)
      expect(report.state).to eq(state)
    end
  end

  describe "#zip" do 
    it "returns zip of the consignee's address" do 
      zip = order.zip 
      report = ShippingInstruction.new(order)
      expect(report.zip).to eq(zip)
    end
  end

  describe "#container" do 
    it "returns the order container size" do 
      container = order.container_size
      report = ShippingInstruction.new(order)
      expect(report.container).to eq(container)
    end
  end

  describe "#load_count" do 
    it "returns the number of orders(aka loads) associated with the contract" do 
      count = order.contract.orders.count 
      report = ShippingInstruction.new(order)
      expect(report.load_count).to eq(count)
    end
  end

  describe "#pack_count" do 
    it "returns the pack count of the first item on the order" do 
      count = order.contract.orders.count
      report = ShippingInstruction.new(order)
      expect(report.load_count).to eq(count)
    end
  end

  describe "#shipping_company" do 
    it "returns the shipping company on the order" do 
      company = order.shipping_company
      report = ShippingInstruction.new(order)
      expect(report.shipping_company).to eq(company)
    end
  end

  describe "#vessel" do 
    it "returns the vessel on the order" do 
      vessel = order.vessel
      report = ShippingInstruction.new(order)
      expect(report.vessel).to eq(vessel)
    end
  end

  describe "#voyage" do 
    it "returns the voyage on the order" do 
      voyage = order.voyage
      report = ShippingInstruction.new(order)
      expect(report.voyage).to eq(voyage)
    end
  end

  describe "#booking_number" do 
    it "returns the booking number on the order" do 
      booking = order.booking_number
      report = ShippingInstruction.new(order)
      expect(report.booking_number).to eq(booking)
    end
  end

  describe "#port" do 
    it "returns the port of discharge on the order" do 
      port = order.port_of_discharge
      report = ShippingInstruction.new(order)
      expect(report.port).to eq(port)
    end
  end

  describe "#booking_number" do 
    it "returns the booking number on the order" do 
      booking = order.booking_number
      report = ShippingInstruction.new(order)
      expect(report.booking_number).to eq(booking)
    end
  end

  describe "#last_received_date" do 
    it "returns the last_received_date on the order" do 
      date = order.last_received_date.strftime("%m/%d/%Y")
      report = ShippingInstruction.new(order)
      expect(report.last_received_date).to eq(date)
    end
  end

  describe "#doc_cut_off" do 
    it "returns the doc_cut_off date on the order" do 
      date = order.doc_cut_off.strftime("%m/%d/%Y")
      report = ShippingInstruction.new(order)
      expect(report.doc_cut_off).to eq(date)
    end
  end

  describe "#estimated_arrival_date" do 
    it "returns the estimated_arrival_date date on the order" do 
      date = order.estimated_arrival_date.strftime("%m/%d/%Y")
      report = ShippingInstruction.new(order)
      expect(report.estimated_arrival_date).to eq(date)
    end
  end

  describe "#ship_pick_up" do 
    it "returns the ship pick up  on the order" do 
      note = order.ship_pick_up
      report = ShippingInstruction.new(order)
      expect(report.ship_pick_up).to eq(note)
    end
  end

  describe "#ship_delivery" do 
    it "returns the ship_delivery up  on the order" do 
      note = order.ship_delivery
      report = ShippingInstruction.new(order)
      expect(report.ship_delivery).to eq(note)
    end
  end

  describe "#documents" do 
    it "returns the documents on the order" do 
      doc1 = Document.create(name: "Special Report")
      doc2 = Document.create(name: "Quality Inspection")
      order.documents << doc1
      order.documents << doc2

      documents = order.documents.map { |document| document.name }.join(", ")
      report = ShippingInstruction.new(order)
      expect(report.documents).to include("Special Report")
      expect(report.documents).to include("Quality Inspection")
    end
  end

  describe "#mail_to" do 
    it "returns the name of the mail_to on the order" do 
      name = order.mail_to.name
      report = ShippingInstruction.new(order)
      expect(report.mail_to).to eq(name)
    end
  end

  describe "#mail_to_line1" do 
    it "returns line1 of the mailto's first mailling address" do
      order.mail_to.addresses << Fabricate(:address)
      line1 = order.mail_to.addresses.first.line1
      report = ShippingInstruction.new(order)
      expect(report.mail_to_line1).to eq(line1)
    end
  end

  describe "#mail_to_city" do 
    it "returns city of the mailto's first mailling address" do
      order.mail_to.addresses << Fabricate(:address)
      city = order.mail_to.addresses.first.city
      report = ShippingInstruction.new(order)
      expect(report.mail_to_city).to eq(city)
    end
  end

  describe "#mail_to_state" do 
    it "returns state of the mailto's first mailling address" do
      order.mail_to.addresses << Fabricate(:address)
      state = order.mail_to.addresses.first.state
      report = ShippingInstruction.new(order)
      expect(report.mail_to_state).to eq(state)
    end
  end

  describe "#mail_to_zip" do 
    it "returns state of the mailto's first mailling address" do
      order.mail_to.addresses << Fabricate(:address)
      zip = order.mail_to.addresses.first.zip
      report = ShippingInstruction.new(order)
      expect(report.mail_to_zip).to eq(zip)
    end
  end

  describe "#shipping_instructions" do 
    it "returns order's shipping instructions" do
      instructions = order.shipping_instructions
      report = ShippingInstruction.new(order)
      expect(report.shipping_instructions).to eq(instructions)
    end
  end

  describe "#origin" do 
    it "returns the origin of the first item on the order" do 
      origin = order.order_line_items.first.item.origin.name
      report = ShippingInstruction.new(order)
      expect(report.origin).to eq(origin)
    end
  end

  describe "#commodity" do 
    it "returns the commodity of the first item on the order" do 
      commodity = order.order_line_items.first.item.commodity.name
      report = ShippingInstruction.new(order)
      expect(report.commodity).to eq(commodity)
    end
  end
end