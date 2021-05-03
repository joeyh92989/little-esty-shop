class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :bulk_discounts, through: :item
  enum status: %i[pending packaged shipped]

  validates :quantity, :unit_price, :status, presence: true

  def applicable_discount
    bulk_discounts.where('bulk_discounts.threshold <= ?', quantity)
                  .order(discount: :desc).first
  end
end
