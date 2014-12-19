require 'spec_helper'

describe OrderLineItem do 
  it { should belong_to(:order) }
  it { should belong_to(:item) }
  it { should belong_to(:quote_line_item) }
  it { should belong_to(:weight) }

  it "should call set_price_if_blank before save" do
    order_line_item = Fabricate(:order_line_item)
    (order_line_item).should_receive(:set_price_if_blank).and_return(2)
    order_line_item.save
  end

  describe "#set_price_if_blank" do
    it "sets the price cents to 0 if blank" do 
      line_item = Fabricate(:order_line_item, price_cents: nil)
      expect(line_item.price_cents).to eq(0)
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

  describe "#weight_kilograms" do
    it "displays 1000 grams as 1 kilogram" do 
      item = OrderLineItem.create(weight_grams: 1000)
      expect(item.weight_kilograms).to eq(1)
    end
  end

  describe "#weight_kilograms=" do
    it "updates weight_grams to 1000 grams" do 
      item = OrderLineItem.create()
      item.weight_kilograms = 1
      expect(item.weight_grams).to eq(1000)
    end
  end

  describe "#weight_pounds" do 
    it "displays 1000 grams as 2.20462262185 pounds" do 
      item = OrderLineItem.create(weight_grams: 1000)
      expect(item.weight_pounds).to eq(2.20462262185)
    end
  end

  describe "#weight_pounds=" do 
    it "displays 1000 grams as 2.20462262185 pounds" do 
      item = OrderLineItem.create()
      item.weight_pounds = 2.20462262185
      expect(item.weight_grams).to eq(1000)
    end
  end

end