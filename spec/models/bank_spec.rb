require 'spec_helper'

describe Bank do 
  it { should belong_to :account }
end