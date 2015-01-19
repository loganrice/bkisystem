require 'spec_helper'

describe Order do 
  it { should belong_to(:contract) }
  it { should have_many(:order_line_items) }
  it { should accept_nested_attributes_for(:order_line_items) }
  it { should validate_presence_of(:contract)}
  it { should have_many(:commissions) }
  it { should accept_nested_attributes_for(:commissions) }
  
  it "it should call set default values before save" do
    order = Fabricate(:order)
    (order).should_receive(:default_values).and_return(2)
    order.save
  end


  it "sort OrderDetails sort descending order by creation date" do 
    order = Fabricate(:order)
    month_ago = Fabricate(:order_line_item, created_at: 1.month.ago, order_id: order.id)
    hour_ago = Fabricate(:order_line_item, created_at: 1.hour.ago, order_id: order.id)
    day_ago = Fabricate(:order_line_item, created_at: 1.day.ago, order_id: order.id)
    order.reload
    expect(order.order_line_items).to eq([hour_ago, day_ago, month_ago])

  end
  
  describe "#row_on_contract" do 
    it "asks it's parent contract to return it's position in the array of orders" do
      contract = Fabricate(:contract)
      order1 = Fabricate(:order, contract_id: contract.id)
      order2 = Fabricate(:order, contract_id: contract.id)
      order3 = Fabricate(:order, contract_id: contract.id)

      expect(order2.row_on_contract).to eq (2)
    end
  end

  describe "#total_pounds" do 
    it "sums up all the pounds in the order line items" do 
      order = Fabricate(:order)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, pack_count: 1, pack_weight_pounds: 1000)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, pack_count: 1, pack_weight_pounds: 1000) 
      expect(order.total_pounds).to eq(2000)     
    end
  end

  describe "#total_price" do 
    it "sums up all the price in dollars of the order line items" do 
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 447)
      commission1 = Commission.create(percent: 2, broker_id: Fabricate(:account).id)
      commission2 = Commission.create(cents_per_pound: 3, broker_id: Fabricate(:account).id)
      order.commissions << commission1
      order.commissions << commission2
      order.save
      expect(order.total_price).to eq(10102200)     
    end
  end
  describe "#copy_first_order_line_items" do 
    it "copies the fields from the first order on the contract" do
      order = Fabricate(:order)
      item = Fabricate(:item)
      lb = Weight.create(weight_unit_of_measure: "lbs")
      order.order_line_items << OrderLineItem.create(item_id: item.id, price_cents: 100,
                                                      order_id: order.id, weight_id: lb.id,
                                                      pack_weight_pounds: 50, pack_count: 10 ) 
      contract = Fabricate(:contract)
      contract.orders << order
      new_order = contract.orders.create()
      # all attributes except for id and created dates should copy
      # only testing the item item_id for brevity
      old_order_last_item = order.order_line_items.last.attributes
      new_order_last_item = new_order.order_line_items.last.attributes
   
      expect(new_order_last_item["item_id"]).to eq(old_order_last_item["item_id"])
    end
  end

  describe "#copy_first_order_commissions" do 
    it "copies the commissions from the first order on the contract" do
      contract = Fabricate(:contract)
      order = Fabricate(:order, contract_id: contract.id)
      item = Fabricate(:item)
      lb = Weight.create(weight_unit_of_measure: "lbs")
      order.order_line_items << OrderLineItem.create(item_id: item.id, price_cents: 100,
                                                      order_id: order.id, weight_id: lb.id,
                                                      pack_weight_pounds: 50, pack_count: 10 ) 
      commission = Fabricate(:commission, order_id: order.id)
      new_order = contract.orders.create()

      first_order_last_commission = order.commissions.last.attributes
      new_order_last_commission = new_order.commissions.last.attributes
      # all attributes except for id and created dates should copy
      # only testing the cents_per_pound for brevity
      expect(new_order_last_commission["cents_per_pound"]).to eq(first_order_last_commission["cents_per_pound"])
    end
  end

end