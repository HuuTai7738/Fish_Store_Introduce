FactoryBot.define do
  factory :order_details do
    quantity {Faker::Number.non_zero_digit}
    price {Faker::Commerce.price(range: 1..100.0, as_string: true)}
    unit {"1kg"}
    product_id {FactoryBot.create(:product).id}
    order_id {FactoryBot.create(:order).id}
  end
end
