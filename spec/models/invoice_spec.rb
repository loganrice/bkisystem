require 'spec_helper'

describe Invoice do 
  it { should belong_to :order }
  it { should belong_to :bank }
  it { should belong_to :payee }
  it { should belong_to :payer }
  it { should belong_to :address }
  it { should have_many :invoice_line_items }
  it { should validate_presence_of :payee_id}
  it { should validate_presence_of :payer_id}
  it { should validate_presence_of :address_id}
  it { should validate_presence_of :bank_id}
  it { should validate_presence_of :order_id}
  it { should accept_nested_attributes_for(:invoice_line_items) }

end