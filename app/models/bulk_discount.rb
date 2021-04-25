class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :name, :threshold, :discount, presence: true
  validates :threshold, :discount, numericality: true
  
end