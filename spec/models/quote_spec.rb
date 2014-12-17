require 'spec_helper'

describe Quote do 
  it { should belong_to(:contract) }
  it { should have_many(:quote_line_items) }
  it { should accept_nested_attributes_for(:quote_line_items) }
end