require 'spec_helper'

describe Order do 
  it { should belong_to(:contract) }
  it { should have_many(:order_line_items) }
  it { should accept_nested_attributes_for(:order_line_items) }

  it "sort OrderDetails sort descending order by creation date" do 
    order = Fabricate(:order)
    month_ago = Fabricate(:order_line_item, created_at: 1.month.ago, order_id: order.id)
    hour_ago = Fabricate(:order_line_item, created_at: 1.hour.ago, order_id: order.id)
    day_ago = Fabricate(:order_line_item, created_at: 1.day.ago, order_id: order.id)
    order.reload
    expect(order.order_line_items).to eq([hour_ago, day_ago, month_ago])

  end
  
end