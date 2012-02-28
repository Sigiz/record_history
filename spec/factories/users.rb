FactoryGirl.define do
  factory :user do
    login { Faker::Internet.email }
    password { Faker::Base.letterify('??????') }
    name { Faker::Name.name }
  end
end