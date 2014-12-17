require 'spec_helper'

describe QuoteLineItem do 
  it { should belong_to(:quote) }
  it { should belong_to(:item) }
  it { should have_many(:order_line_items)}
end