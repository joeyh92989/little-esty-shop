class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, :description, :unit_price, :merchant_id, presence: true
  def self.top_5
    Item.select(:name,:id)
    .joins(:invoice_items)
    .joins(invoices: :transactions)
    .where('transactions.result = 0')
    .group(:id)
    .select('SUM(invoice_items.unit_price * invoice_items.quantity) as tot').order('tot')
  end
  def total_rev
    
    invoice_items.joins(invoice: :transactions).where('transactions.result = 0').sum('invoice_items.unit_price * invoice_items.quantity')
  end
end