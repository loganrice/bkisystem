Fabricator(:remark) do
  name { Faker::Lorem.word }
  description { Faker::Lorem.word }
end