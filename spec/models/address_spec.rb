require 'spec_helper'

describe Address do 
  it { should belong_to :addressable }
  it { should have_many :orders }
end
