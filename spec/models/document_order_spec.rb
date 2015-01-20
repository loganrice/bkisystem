require 'spec_helper'

describe DocumentOrder do 
  it { should belong_to(:order) }
  it { should belong_to(:document) }
end