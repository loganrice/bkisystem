require 'spec_helper'

describe Bank do 
  it { should belong_to :account }
  it { should have_many :orders }
end