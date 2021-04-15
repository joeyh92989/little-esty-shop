require 'rails_helper'


RSpec.describe 'merchant dashboard' do
  it "shows merchant name" do
    merchant_1 = create(:merchant)

    visit "/merchants/#{merchant_1.id}/dashboard"

    expect(page).to have_content(merchant_1.name)
  end

  it "show link to items index" do
    merchant_1 = create(:merchant)
    visit "/merchants/#{merchant_1.id}/dashboard"

    click_link("Items")
    expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
  end

  it "show link to invoices index" do
    merchant_1 = create(:merchant)
    visit "/merchants/#{merchant_1.id}/dashboard"

    click_link("Invoices")
    expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices")
  end
end
