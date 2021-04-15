class Merchant < ApplicationRecord
  has_many :items
  has_many :dashbaords
  validates :name, presence: true
end
