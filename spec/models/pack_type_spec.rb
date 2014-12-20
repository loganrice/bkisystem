require 'spec_helper'

describe PackType do 
  it { should have_many(:quote_line_items) }
end