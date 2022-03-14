FactoryBot.define do
  factory :order do
    order_date {Time.zone.now}
    status {"new_order"}
    order_address {Faker::Address.street_address}
    user_id {FactoryBot.create(:user, confirmed_at: Time.zone.now).id}
  end
end
