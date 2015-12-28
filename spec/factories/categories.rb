FactoryGirl.define do
  factory :category do
    title "Programming"
  end

  after(:build) do |category|
    category.valid?
  end
end
