FactoryBot.define do
  factory :bulk_discount do
    threshold { Faker::Number.between(from: 1, to: 10) }
    discount { Faker::Number.decimal(l_digits: 0, r_digits: 2)}
    name { Faker::Commerce.promotion_code }

    merchant
  end
end
