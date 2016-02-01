FactoryGirl.define do
  factory :reqview do
    text { Faker::Lorem.paragraph }
    value { Faker::Number.number(1).to_i + 1 }
    book
    customer
  end
end
