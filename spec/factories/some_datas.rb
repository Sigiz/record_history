FactoryGirl.define do
  factory :some_data do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence(3) }
    value { Faker::Base.numerify('###') }
  end
end
