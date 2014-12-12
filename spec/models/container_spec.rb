require 'spec_helper'

describe Container do 
  it { should belong_to(:shipment) }

  describe "#price_dollars=" do
    it "converts $12.93 dollars to 1293 cents" do 
      amount = Container.create()
      amount.price_dollars = 12.93
      expect(amount.price_cents).to eq(1293)
    end
  end

  describe "#price_dollars" do 
    it "displays 1293 cents as 12.93" do 
      amount = Container.create(price_cents: 1293)
      expect(amount.price_dollars).to eq(12.93)
    end
  end

end