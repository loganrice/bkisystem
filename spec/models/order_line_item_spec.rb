require 'spec_helper'

describe OrderLineItem do 
  it { should belong_to(:order) }
  it { should belong_to(:item) }
  it { should belong_to(:quote_line_item) }
  it { should belong_to(:weight) }


  it "converts 5000 kgs to pounds and then back to 5000 kgs" do 
    item = OrderLineItem.create()
    item.pack_weight_kilograms = 5000
    item.save
    expect(item.pack_weight_kilograms).to eq(5000)
  end

  it "should set price_cents to 0 if blank before save" do
    order_line_item = Fabricate(:order_line_item)
    (order_line_item).should_receive(:default_values).and_return(2)
    order_line_item.save
  end

  describe "#set_price_if_blank" do
    it "sets the price cents to 0 if blank" do 
      line_item = Fabricate(:order_line_item, price_cents: nil)
      expect(line_item.price_cents).to eq(0)
    end

    it "sets weight_pounds to 0 if blank" do 
      line_item = Fabricate(:order_line_item, pack_weight_pounds: nil)

    end
  end

  describe "#price_dollars=" do
    it "converts $12.93 dollars to 1293 cents" do 
      amount = OrderLineItem.create()
      amount.price_dollars = 12.93
      expect(amount.price_cents).to eq(1293)
    end

    it "does not update if can not convert dollars to float" do 
      amount = QuoteLineItem.create()
      amount.price_dollars = "1"
      amount.price_dollars = "1abc"
      expect(amount.price_cents).to eq(100)
    end
  end

  describe "#price_dollars" do 
    it "displays 1293 cents as 12.93" do 
      amount = OrderLineItem.create(price_cents: 1293)
      expect(amount.price_dollars).to eq(12.93)
    end
  end

  describe "#shipment_date" do 
    it "displays order date 2/3/2020" do 
      new_shipment = Fabricate(:order, ship_date: Date.new(2020,2,3) )
      container = OrderLineItem.create()
      container.order = new_shipment
      expect(container.shipment_date).to eq(Date.new(2020,2,3))
    end
  end

  describe "#pack_weight_kilograms" do 
    it "displays 5000 pounds as 2267.962 kilogram" do 
      item = OrderLineItem.create(pack_weight_pounds: 5000)
      expect(item.pack_weight_kilograms.to_s).to eq("2267.962")
    end
  end

  describe "#pack_weight_kilograms=" do
    it "updates pack weight pounds to 5000 pounds" do 
      item = OrderLineItem.create()
      item.pack_weight_kilograms = 5000
      expect(item.pack_weight_pounds.to_s).to eq("11023.113")
    end
  end
end