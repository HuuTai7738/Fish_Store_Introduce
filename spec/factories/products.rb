FactoryBot.define do
  factory :product do
    name {Faker::Food.sushi}
    description {Faker::Food.description}
    status {0}
    price {Faker::Commerce.price(range: 1..100.0, as_string: true)}
    unit {"1kg"}
    quantity {Faker::Number.between(from: 90, to: 100)}
    association :category
  end
end
