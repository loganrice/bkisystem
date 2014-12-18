require 'spec_helper'

describe Weight do 
  it { should have_many(:order_line_items) }

end