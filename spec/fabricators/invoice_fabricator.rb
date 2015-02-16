Fabricator(:invoice) do
  payee_id { Fabricate(:account).id }
  payer_id { Fabricate(:account).id }
  address_id { Fabricate(:account).id }
  bank_id { Fabricate(:bank).id }
end