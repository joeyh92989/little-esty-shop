class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  validates :first_name, :last_name, presence: true

  def self.top_5
    self.joins(invoices: :transactions)
    .where('transactions.result = 0')
    .group(:id)
    .order('transactions.count DESC')
    .limit(5)
  end
  def number_of_succesful_transactions
    invoices.joins(:transactions)
    .where('transactions.result = 0').count
  end
end
