require "rails_helper"

RSpec.describe "bulk discount show" do
  before :each do
    @merchant_1 = create(:merchant)
    @bulk_discount = create :bulk_discount, merchant: @merchant_1
    @item = create_list(:item, 6, merchant: @merchant_1)
  end

  it "lists a bulk_discounts details" do
      visit "/merchants/#{@merchant_1.id}/bulk_discounts/#{@bulk_discount.id}"

      expect(page).to have_content("Name: #{@bulk_discount.name}")
      expect(page).to have_content("Threshold: #{@bulk_discount.threshold}")
      expect(page).to have_content("Discount: #{((@bulk_discount.discount))}%")
  end
end
