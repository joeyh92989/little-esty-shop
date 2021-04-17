class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true
  validates :status, presence: true

  def self.enabled
    where(status: "enabled")
  end

  def self.disabled
    where(status: "disabled")
  end
end
