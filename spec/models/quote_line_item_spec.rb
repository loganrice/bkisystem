require 'spec_helper'

describe QuoteLineItem do 
  it { should belong_to(:quote) }
  it { should belong_to(:item) }
  it { should have_many(:order_line_items)}
  it { should belong_to(:item_size_indicator)}
  it { should belong_to(:pack_type)}
  
  it "should delete accociate order line items" do
    quote_line_item = Fabricate(:quote_line_item)
    order_line_item = Fabricate(:order_line_item, quote_line_item_id: quote_line_item.id)
    quote_line_item.destroy

    expect(QuoteLineItem.count).to eq(0)
    expect(OrderLineItem.count).to eq(0)
  end

  describe "#pack_weight_kilograms" do 
    it "displays 1000 grams as 1 kilogram" do 
      item = QuoteLineItem.create(pack_weight_grams: 1000)
      expect(item.pack_weight_kilograms).to eq(1)
    end
  end

  describe "#pack_weight_kilograms=" do
    it "updates pack weight grams to 1000 grams" do 
      item = QuoteLineItem.create()
      item.pack_weight_kilograms = 1
      expect(item.pack_weight_grams).to eq(1000)
    end
  end

  describe "#pack_weight_pounds" do 
    it "displays 1000 grams as 2.20462262185 pounds" do 
      item = QuoteLineItem.create(pack_weight_grams: 1000)
      expect(item.pack_weight_pounds).to eq(2.20462262185)
    end
  end

  describe "#weight_pounds=" do 
    it "displays 1000 grams as 2.20462262185 pounds" do 
      item = QuoteLineItem.create()
      item.pack_weight_pounds = 2.20462262185
      expect(item.pack_weight_grams).to eq(1000)
    end
  end

  describe "#price_dollars=" do
    it "converts $12.93 dollars to 1293 cents" do 
      amount = QuoteLineItem.create()
      amount.price_dollars = 12.93
      expect(amount.price_cents).to eq(1293)
    end

    it "converts $1 dollar to 100 cents" do 
      amount = QuoteLineItem.create()
      amount.price_dollars = "1"
      expect(amount.price_cents).to eq(100)
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
      amount = QuoteLineItem.create(price_cents: 1293)
      expect(amount.price_dollars).to eq(12.93)
    end

    it "displays 100 cents as 1" do 
      amount = QuoteLineItem.create(price_cents: 100)
      expect(amount.price_dollars).to eq(1)
    end
  end

end