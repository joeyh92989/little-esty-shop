class Transaction < ApplicationRecord
  belongs_to :invoice
  enum result: { success: 0, failed: 1 }

  validates :credit_card_number, :result, :invoice_id, presence: true
end
