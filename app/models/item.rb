class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :bulk_discounts, through: :merchant

  validates :name, :description, :unit_price, :merchant_id, presence: true

  def total_rev
    invoice_items.joins(invoice: :transactions)
    .where('transactions.result = 0')
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def self.enabled
    where(status: "enabled")
  end

  def self.disabled
    where(status: "disabled")
  end
  def top_day
    invoices.
    select('invoices.created_at')
    .group('invoices.created_at')
    .order(count: :desc)
    .first
    .created_at
  end
end
