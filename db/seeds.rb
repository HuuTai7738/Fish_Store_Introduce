User.create!(name: "Admin",
  email: "admin@store.com",
  password: "123123",
  password_confirmation: "123123",
  phone: Faker::PhoneNumber.phone_number,
  role: 1)

10.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password,
                phone: Faker::PhoneNumber.phone_number
  )
end

5.times do
  Category.create(name:Faker::Food.sushi)
end

30.times do
  Product.create(name: Faker::Food.sushi,
                 description: Faker::Food.description,
                 status: 0,
                 price: Faker::Commerce.price(range: 1..100.0, as_string: true),
                 unit: "1kg",
                 quantity: Faker::Number.between(from: 90, to: 100),
                 category_id: Category.pluck(:id).sample)
end
