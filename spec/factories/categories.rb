FactoryGirl.define do
  factory :category do
    sequence :title do |n|
      "Category \##{n}"
    end
  end

  after(:build) do |category|
    category.valid?
  end
end
