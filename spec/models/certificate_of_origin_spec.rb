require 'spec_helper'

describe CertificateOfOrigin do 
  it { should belong_to :order }
  it { should validate_presence_of :order }
  it { should validate_presence_of :forwarding_agent }
end