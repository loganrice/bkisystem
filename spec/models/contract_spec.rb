require 'spec_helper'

describe Contract do 
  it { should belong_to(:buyer) }
  it { should belong_to(:seller) }
  it { should have_one(:quote) }
  it { should have_many(:quote_line_items).through(:quote)}
  it { should have_many(:orders) }
  it { should accept_nested_attributes_for(:orders) }

end

