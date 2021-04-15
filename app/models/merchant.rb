class Merchant < ApplicationRecord
  has_many :items
  has_many :dashboards
  validates :name, presence: true
end
