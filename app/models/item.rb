class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, :description, :unit_price, :merchant_id, presence: true

  def total_rev
    
    invoice_items.joins(invoice: :transactions).where('transactions.result = 0').sum('invoice_items.unit_price * invoice_items.quantity')
  end
end