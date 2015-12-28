FactoryGirl.define do
  factory :book do
    title "Everyday Rails Spec"
    description "Perfect reading to start using RSpec with Rails"
    price 11.50
    in_stock 3
    author
    category

    factory :out_of_stock_book do
      in_stock 0
    end
  end

  after(:build) do |book|
    book.valid?
  end
end
