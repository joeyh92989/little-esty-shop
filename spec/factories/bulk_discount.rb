FactoryBot.define do
  factory :bulk_discount do
    threshold { Faker::Number.between(from: 1, to: 10) }
    discount { Faker::Number.between(from: 1, to: 99)}
    name { Faker::Commerce.promotion_code }

    merchant
  end
end
