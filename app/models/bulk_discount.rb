class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :name, :threshold, :discount, presence: true
  validates :threshold, numericality: true
  validates :discount, numericality: true
  validates :threshold, numericality: { greater_than: 0 }
  validates :discount, numericality: { greater_than: 0, less_than: 100 }
end
