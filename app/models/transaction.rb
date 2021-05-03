class Transaction < ApplicationRecord
  belongs_to :invoice
  enum result: %i[success failed]

  validates :credit_card_number, :result, :invoice_id, presence: true
end
