require 'spec_helper'

describe QuoteLineItem do 
  it { should belong_to(:quote) }
  it { should belong_to(:item) }
  it { should have_many(:order_line_items)}

  describe "#price_dollars=" do
    it "converts $12.93 dollars to 1293 cents" do 
      amount = QuoteLineItem.create()
      amount.price_dollars = 12.93
      expect(amount.price_cents).to eq(1293)
    end
  end

  describe "#price_dollars" do 
    it "displays 1293 cents as 12.93" do 
      amount = QuoteLineItem.create(price_cents: 1293)
      expect(amount.price_dollars).to eq(12.93)
    end
  end

end