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
                 phone: Faker::PhoneNumber.phone_number,
    )
  end
