require 'spec_helper'

describe OrderLineItem do 
  it { should belong_to(:order) }
  it { should belong_to(:item) }
  it { should belong_to(:quote_line_item) }
  it { should belong_to(:weight) }
  it { should have_many(:commissions).through(:order)}
  it { should validate_presence_of(:item)}

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

  it "should match contract AA 72029 load 1 commission $5,297.60" do 
      order = Fabricate(:order)
      item1 = OrderLineItem.create(order_id: order.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 447)
      item2 = OrderLineItem.create(order_id: order.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 433)

      commission1 = Commission.create(cents_per_pound: 3, broker_id: Fabricate(:account).id)
      commission2 = Commission.create(percent: 2, broker_id: Fabricate(:account).id)
      order.commissions << commission1
      order.commissions << commission2
      order.save
      expect(item1.commission_total).to eq(BigDecimal.new("269094"))
      expect(item2.commission_total).to eq(BigDecimal.new("260666"))
      total_commission = item1.commission_total + item2.commission_total
      expect(total_commission).to eq(BigDecimal.new("529760"))

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

    it "after price_dollars= converts 4.52 to cents it displays 4.52 cents" do 
      amount = OrderLineItem.create()
      amount.price_dollars = 4.52
      expect(amount.price_cents).to eq(452)
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

  describe "#total_commission_cents_per_pound" do 
    it "gets all of the associated Commissions and adds the cents per pound fields" do 
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id)
      commission1 = Commission.create(cents_per_pound: 30, broker_id: Fabricate(:account).id)
      commission2 = Commission.create(cents_per_pound: 5, broker_id: Fabricate(:account).id)
      order.commissions << commission1
      order.commissions << commission2
      order.save
      expect(item.total_commission_cents_per_pound).to eq(35)
    end
  end

  describe "#total_commission_percent" do 
    it "gets all of the associated Commissions and adds the percent fields" do 
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id)
      commission1 = Commission.create(percent: BigDecimal.new("2.0"), broker_id: Fabricate(:account).id)
      commission2 = Commission.create(percent: BigDecimal.new("2.0"), broker_id: Fabricate(:account).id)
      order.commissions << commission1
      order.commissions << commission2
      order.save
      expect(item.total_commission_percent).to eq(4)
    end
  end

  describe "#total_commission_cents" do 
    it "gets all of the associated Commissions and adds the cents fields" do 
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id)
      commission1 = Commission.create(cents: 100, broker_id: Fabricate(:account).id)
      commission2 = Commission.create(cents: 150, broker_id: Fabricate(:account).id)
      order.commissions << commission1
      order.commissions << commission2
      order.save
      expect(item.total_commission_cents).to eq(250)
    end
  end
  describe "#total_commission_percent_as_decimal" do 
    it "converts percent to decimal form i.e. 2.0 eq .02" do 
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id)
      commission1 = Commission.create(percent: BigDecimal.new("2.0"), broker_id: Fabricate(:account).id)
      commission2 = Commission.create(percent: BigDecimal.new("2.0"), broker_id: Fabricate(:account).id)
      order.commissions << commission1
      order.commissions << commission2
      order.save
      expect(item.total_commission_percent_as_decimal).to eq(BigDecimal.new("0.04"))
    end
  end

  describe "#adjusted_price" do 
    it "deducts the total_commission_cents_per_pound from price_cents" do 
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id, price_cents: 100)
      commission1 = Commission.create(cents_per_pound: 3, broker_id: Fabricate(:account).id)
      commission2 = Commission.create(cents_per_pound: 3, broker_id: Fabricate(:account).id)
      order.commissions << commission1
      order.commissions << commission2
      order.save
      expect(item.adjusted_price).to eq(94)
    end
    it "deducts the total_commission_cents_per_pound from price_cents" do 
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 447)
      commission1 = Commission.create(cents_per_pound: 3, broker_id: Fabricate(:account).id)
      commission2 = Commission.create(percent: 2, broker_id: Fabricate(:account).id)
      order.commissions << commission1
      order.commissions << commission2
      order.save
      expect(item.adjusted_price).to eq(BigDecimal.new("439.96"))
    end
  end

  describe "#adjusted_total" do
    it "multiplies the adjusted_price by the total_weight" do 
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 447)
      commission1 = Commission.create(percent: 2, broker_id: Fabricate(:account).id)
      commission2 = Commission.create(cents_per_pound: 3, broker_id: Fabricate(:account).id)
      order.commissions << commission1
      order.commissions << commission2
      order.save
      expect(item.adjusted_total).to eq(9833106) 
    end
  end

  describe "#invoice_total" do 
    it "calculates the total price based on weight x price_cents" do 
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 447)
      commission1 = Commission.create(percent: 2, broker_id: Fabricate(:account).id)
      commission2 = Commission.create(cents_per_pound: 3, broker_id: Fabricate(:account).id)
      order.commissions << commission1
      order.commissions << commission2
      order.save
      expect(item.invoice_total).to eq(BigDecimal.new("10102200.00"))     
    end
  end

  describe "#commission_total" do 
    it "calculates the total price based on weight x price_cents" do 
      require 'pry';
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 447)
      commission1 = Commission.create(percent: 2, broker_id: Fabricate(:account).id)
      commission2 = Commission.create(cents_per_pound: 3, broker_id: Fabricate(:account).id)
      order.commissions << commission1
      order.commissions << commission2
      order.save
      expect(item.commission_total).to eq(269094)     
    end
  end

  describe "#weight_total" do 
    it "calculates the total weight by pack_weight_pounds x pack_count" do 
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 447)
      expect(item.weight_total).to eq(BigDecimal.new("22350")) 
    end

    it "equals zero if pack_count or pack_weight_pounds is nil" do 
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id, item_id: Fabricate(:item).id, price_cents: 452, pack_count: 447)
      expect(item.weight_total).to eq(BigDecimal.new("0")) 
    end
  end
end