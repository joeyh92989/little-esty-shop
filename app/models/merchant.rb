class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true
  validates :status, presence: true

  def self.top_5_merchants_by_revenue
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

  def top_5_by_transactions
    customers.joins(:transactions)
    .where(transactions: {result: 0})
    .group('customers.id')
    .select('customers.*, count(*) AS successful_transactions')
    .order('successful_transactions DESC')
    .limit(5)
  end

  def items_ready_to_ship
    invoice_items.joins(:invoice)
    .where('invoice_items.status = 1')
    .order('invoices.created_at')
    .limit(4)
  end

  def total_revenue
    invoice_items.group(:id)
    .sum('invoice_items.quantity * invoice_items.unit_price')
    .values
    .sum
  end

  def top_merchant_best_day
    invoices.joins(:invoice_items)
    .select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
    .group('created_at')
    .order('total_revenue')
    .first
    .created_at
  end
  def top_5_items
     items.select(:name,:id)
     .joins(:invoice_items)
     .joins(invoices: :transactions)
     .where('transactions.result = 0')
     .group(:id)
     .select('SUM(invoice_items.unit_price * invoice_items.quantity) as tot')
     .order('tot')
     .limit(5)
  end
end
