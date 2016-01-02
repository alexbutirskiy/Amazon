FactoryGirl.define do
  factory :order do
    total_price { Faker::Commerce.price }
    completed_date { Faker::Date.forward(30) }
    state 'in_progress'
    customer
    credit_card
  end

end
