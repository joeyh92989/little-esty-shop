class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates :name, presence: true

  def invoice_items_not_shipped
    InvoiceItem.joins(:item, :invoice)
    .where(invoice_items: {status: "pending"})
    .group(:id)
    .limit(4)
    # .order(:invoice, created_at: :desc)
  end

  def self.enabled
    where(status: "enabled")
  end

  def self.disabled
    where(status: "disabled")
  end
end
