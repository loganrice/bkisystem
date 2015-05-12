Fabricator(:certificate_of_origin) do
  hs_code { Faker::Lorem.word }
  treatment { Faker::Lorem.word }
  place_of_initial_receipt { Faker::Lorem.word }
  port_of_loading { Faker::Lorem.word }
  forwarding_agent { Faker::Lorem.word }
  initial_carriage_by { Faker::Lorem.word }
  vessel { Faker::Lorem.word }
  order_id { Fabricate(:order).id }
  routing_instructions { Faker::Lorem.word }
end