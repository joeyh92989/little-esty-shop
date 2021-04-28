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
    output = invoice_items.joins(:bulk_discounts)
    .where('invoice_items.quantity >= bulk_discounts.threshold')
    .group(:id)
    .select('max(bulk_discounts.discount) as max, invoice_items.*')
    stage= output.map do |invoice_item|
      a = (invoice_item.unit_price * invoice_item.quantity)
      b = (invoice_item.unit_price * invoice_item.quantity * invoice_item.max) / 100
      a-b
    end
    stage.sum
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

