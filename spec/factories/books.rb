FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price + 0.01}
    in_stock { Faker::Number.number(2).to_i }
    sold { Faker::Number.number(2).to_i }
    category

    factory :out_of_stock_book do
      in_stock 0
    end

    after(:build) do |book|
      rand(1..3).times do
        book.authors << create(:author)
      end
    end
  end
end
