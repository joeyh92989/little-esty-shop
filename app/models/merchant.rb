class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true
  validates :status, presence: true

  def self.top_5_by_revenue
    joins(:transactions, :invoice_items)
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .group(:id)
    .where('transactions.result = ?', 0)
    .order('total_revenue desc')
    .limit(5)
  end

  def self.enabled
    where(status: "enabled")
  end

  def self.disabled
    where(status: "disabled")
  end

  def total_revenue
    invoice_items.group(:id)
    .sum('invoice_items.quantity * invoice_items.unit_price')
    .values
    .sum
  end
end
