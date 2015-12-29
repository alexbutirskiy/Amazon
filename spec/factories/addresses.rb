FactoryGirl.define do
  factory :address do
    address Faker::Address.street_address
    zipcode Faker::Address.zip
    city Faker::Address.city
    phone Faker::PhoneNumber.cell_phone
    country Faker::Address.country
  end

end
