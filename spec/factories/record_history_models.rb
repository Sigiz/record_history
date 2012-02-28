FactoryGirl.define do
  factory :record_history_model do
    item_type { 'SomeData' }
    item_id { Factory.create(:some_data).id }
    attr_name { Faker::Lorem.words(1).first }
    old_value_dump { Marshal.dump(Faker::Base.numerify('##')) }
    new_value_dump { Marshal.dump(Faker::Base.numerify('##')) }
    author_type { 'User'}
    author_id { Factory.create(:user) }
  end
end