FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Bank.account_number(digits: 16).to_s }
    result { [0,1].sample }
    invoice
  end
end
