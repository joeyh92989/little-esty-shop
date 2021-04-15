FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.within(range: 1..10) }
    unit_price { Faker::Number.within(range: 1..10) }
    status { [0,1,2].sample }
    invoice
    item
  end
end
