require "rails_helper"

RSpec.describe "merchant dashboard" do
  before :each do
    @merchant_1 = create(:merchant)
    @bulk_discount = create :bulk_discount, merchant: @merchant_1
    @item = create_list(:item, 6, merchant: @merchant_1)
  end

  it "directs to the edit page " do
      visit "/merchants/#{@merchant_1.id}/bulk_discounts/#{@bulk_discount.id}"
      click_link "Edit"
      expect(page).to have_current_path("/merchants/#{@merchant_1.id}/bulk_discounts/#{@bulk_discount.id}/edit")
  end
  it "shows the form with prepulated values " do
    visit "/merchants/#{@merchant_1.id}/bulk_discounts/#{@bulk_discount.id}/edit"
    save_and_open_page
    expect(find("form")).to have_content("Name")
    expect(page).to have_field("Name", with: "#{@bulk_discount.name}")
    expect(find('form')).to have_content('Threshold')
    expect(page).to have_field("Threshold", with: "#{@bulk_discount.threshold}")
    expect(find('form')).to have_content('Discount')
    expect(page).to have_field("Discount", with: "#{(@bulk_discount.discount)*100}")
  end
end