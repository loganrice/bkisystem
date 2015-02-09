Fabricator(:contract) do
  buyer_id { Fabricate(:account).id }
  seller_id { Fabricate(:account).id }
  buyer_contract { Faker::Number.number(10) }
  buyer_po { Faker::Number.number(10) }
  seller_contract { Faker::Number.number(10) }
  date { Faker::Date.between(30.days.ago, Date.today) }
  payment_terms { Faker::Lorem.word }
  remarks { Faker::Lorem.word }
end