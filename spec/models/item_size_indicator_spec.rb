require 'spec_helper'

describe ItemSizeIndicator do 
  it { should have_many(:quote_line_items) }
end