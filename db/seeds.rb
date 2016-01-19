# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env == "development"
  20.times do
    Category.create title: Faker::Book.genre
  end

  100.times do
    Author.create(
      firstname: Faker::Name.first_name,
      lastname: Faker::Name.last_name,
      biography: Faker::Lorem.paragraph * 10)
  end

  500.times do
    b = Book.create(
      category: Category.all.sample,
      title: Faker::Book.title,
      price: (Faker::Commerce.price+1),
      description: Faker::Lorem.paragraph,
      full_description: Faker::Lorem.paragraph * 5,
      in_stock: rand(10),
      sold: rand(20)
    )

    rand(1..3).times do
      b.authors << Author.all.sample
    end
  end
end