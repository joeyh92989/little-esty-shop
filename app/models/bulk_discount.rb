class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :name, :threshold, :discount, presence: true
  validates :threshold, numericality: true
  validates  :discount, numericality: true
  validates_numericality_of :threshold,  greater_than: 0
  validates_numericality_of :discount,  greater_than: 0,  less_than: 100

end