Fabricator(:fumigation) do
  treatment { Faker::Lorem.word }
  duration_of_exposure { Faker::Lorem.word }
  temperature { Faker::Lorem.word }
  hs_code { Faker::Lorem.word }
  date_of_treatment { Faker::Lorem.word }
  concentration { Faker::Lorem.word }
  permit_number { Faker::Lorem.word }
  order_id { Fabricate(:order).id }
  notes { Faker::Lorem.word }
end
