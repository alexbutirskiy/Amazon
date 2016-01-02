FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price }
    in_stock { Faker::Number.number(2).to_i }
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
