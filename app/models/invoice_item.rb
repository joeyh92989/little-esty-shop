class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :bulk_discounts, through: :item
  enum status: { pending: 0, packaged: 1, shipped: 2 }

  validates :quantity, :unit_price, :status, presence: true

  def applicable_discount
    bulk_discounts.where('bulk_discounts.threshold <= ?', quantity)
                  .order(discount: :desc).first
  end
end
