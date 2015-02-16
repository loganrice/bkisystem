
require 'spec_helper'

describe Account do
  it { should validate_presence_of(:name) }
  it { should have_many(:addresses) }
  it { should accept_nested_attributes_for(:addresses) }
  it { should accept_nested_attributes_for(:banks) }
  it { should have_many(:banks) }
  it { should have_many(:selling_contracts)}
  it { should have_many(:buying_contracts)}
  it { should have_many(:commissions) }
  it { should have_many(:mail_tos)}
  it { should have_many(:acting_sellers)}
  it { should have_many(:payees)}
  it { should have_many(:payers)}

end