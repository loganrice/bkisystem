require 'spec_helper'

describe Remark do 
  it { should validate_presence_of :name }
end