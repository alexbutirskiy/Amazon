FactoryGirl.define do
  factory :rating do
    text "MyText"
    value 1
    book
    customer nil
  end
end
