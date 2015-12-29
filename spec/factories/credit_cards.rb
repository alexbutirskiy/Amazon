FactoryGirl.define do
  factory :credit_card do
    number Faker::Business.credit_card_number
    CVV  Faker::Number.number(3)
    expiration_month Faker::Business.credit_card_expiry_date.month
    expiration_year Faker::Business.credit_card_expiry_date.year
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
    customer nil
  end

end
