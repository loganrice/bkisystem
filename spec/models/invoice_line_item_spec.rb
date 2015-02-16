require 'spec_helper'

describe InvoiceLineItem do 
  it { should belong_to :invoice }
  it { should validate_presence_of :amount_cents }

  describe "#amount_dollars=" do
    it "converts $12.93 dollars to 1293 cents" do 
      amount = InvoiceLineItem.create()
      amount.amount_dollars = 12.93
      expect(amount.amount_cents).to eq(1293)
    end
  end

  describe "#amount_dollars" do 
    it "displays 1293 cents as 12.93" do 
      amount = InvoiceLineItem.create(amount_cents: 1293)
      expect(amount.amount_dollars).to eq(12.93)
    end

    it "after amount_dollars= converts 4.52 to cents it displays 4.52 cents" do 
      amount = InvoiceLineItem.create()
      amount.amount_dollars = 4.52
      expect(amount.amount_cents).to eq(452)
    end
  end
end