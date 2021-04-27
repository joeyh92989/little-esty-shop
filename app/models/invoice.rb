class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :bulk_discounts, through: :invoice_items

  enum status: [ :"completed", :"cancelled", :"in progress" ]

  validates :status, presence: true

  def self.unshipped
    self.joins(:invoice_items).group(:id).where.not('invoice_items.status = ?', 2)
  end

  def total_revenue
    invoice_items.sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def discounted_rev
    invoice_items.joins(:bulk_discounts)
    .where('invoice_items.quantity >= bulk_discounts.threshold')
    .sum('invoice_items.unit_price * invoice_items.quantity * bulk_discounts.discount / 100')
  end

  def total_rev_with_discounts
    total = total_revenue
    discount = discounted_rev
    total - discount
  end

  def date
    created_at.strftime("%A, %B, %d, %Y")
  end
end
