FactoryGirl.define do
  factory :some_data do
    name { Faker::Lorem.words(1).first }
    description { Faker::Lorem.sentence(3) }
    value { Faker::Base.numerify('###') }
  end
end