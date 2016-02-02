FactoryGirl.define do
  factory :review do
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph }
    value { Faker::Number.number(1).to_i + 1 }
    book
    customer
  end
end
