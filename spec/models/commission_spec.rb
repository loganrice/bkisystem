require 'spec_helper'

describe Commission do 
  it { should belong_to(:order) }
  it { should belong_to(:broker) }

  describe "#dollars_per_pound" do 
    it "displays 1293 cents per pound as 12.93 dollars per pound" do 
      amount = Commission.create(cents_per_pound: 1293)
      expect(amount.dollars_per_pound).to eq(12.93)
    end

    it "converts $12.93 dollars per pound to 1293 cents per pound" do 
      amount = Commission.create()
      amount.dollars_per_pound = 12.93
      expect(amount.cents_per_pound).to eq(1293)
    end
  end

  describe "#dollars" do 
    it "displays 1293 cents as 12.93 dollars" do 
      amount = Commission.create(cents: 1293)
      expect(amount.dollars).to eq(12.93)
    end
    it "converts $12.93 dollars to 1293 cents" do 
      amount = Commission.create()
      amount.dollars = 12.93999
      expect(amount.cents).to eq(1293)
    end

  end
end