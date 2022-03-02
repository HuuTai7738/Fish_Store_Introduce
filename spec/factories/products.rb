FactoryBot.define do
  factory :product do
    name {Faker::Food.sushi}
    description {Faker::Food.description}
    status {"activated"}
    price {Faker::Commerce.price(range: 1..100.0, as_string: true)}
    unit {"1kg"}
    quantity {Faker::Number.between(from: 90, to: 100)}
    category_id {FactoryBot.create(:category).id}
  end
end
