FactoryBot.define do
  factory :bulk_discount do
    threshhold { Faker::Number.between(from: 1, to: 10) }
    discount { Faker::Number.between(from: 0.0, to: 0.99) }
    name { Faker::Commerce.promotion_code }

    merchant
  end
end
