require 'spec_helper'

describe Document do 
  it { should have_many(:orders).through(:document_orders) }
  it { should validate_presence_of(:name) }

  it "lists in decending order by name" do 
    older_document = Document.create(name: "older document")
    newer_document = Document.create(name: "newer document")

    expect(Document.all).to eq([newer_document, older_document])
  end
end