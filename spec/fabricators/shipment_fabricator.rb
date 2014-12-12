Fabricator(:shipment) do 
  ship_date { Faker::Date.between(30.days.ago, Date.today) }
  last_received_date { Faker::Date.between(30.days.ago, Date.today) }
  doc_cut_off { Faker::Date.between(30.days.ago, Date.today) }
  estimated_arrival_date { Faker::Date.between(30.days.ago, Date.today) }
  shipping_company { Faker::Company.name }
  voyage { Faker::Company.name }
  port_of_discharge { Faker::Address.city }
  vessel { Faker::Company.name }
  ship_in_name_of { Faker::Name.name }
  booking_number { Faker::Number.number(10) }
  commodity { Faker::Lorem.word }
  shipping_company_reference_number { Faker::Number.number(10) }
  automated_export_number { Faker::Number.number(10) }
  payment_terms { Faker::Lorem.word }
  remarks { Faker::Lorem.word }
  ship_pick_up { Faker::Lorem.word }
  ship_delivery { Faker::Lorem.word }
end