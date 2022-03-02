FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    phone {Faker::PhoneNumber.phone_number}
    password {"password"}
    password_confirmation {"password"}
  end
end
