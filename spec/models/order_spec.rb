require 'spec_helper'

describe Order do 
  it { should belong_to(:contract) }
  it { should have_many(:order_details) }
  it { should accept_nested_attributes_for(:order_details) }

  it "sort OrderDetails sort descending order by creation date" do 
    order = Fabricate(:order)
    month_ago = Fabricate(:order_detail, created_at: 1.month.ago, order_id: order.id)
    hour_ago = Fabricate(:order_detail, created_at: 1.hour.ago, order_id: order.id)
    day_ago = Fabricate(:order_detail, created_at: 1.day.ago, order_id: order.id)
    order.reload
    expect(order.order_details).to eq([hour_ago, day_ago, month_ago])

  end
  
end