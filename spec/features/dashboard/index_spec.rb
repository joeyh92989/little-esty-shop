require 'rails_helper'


RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant_1 = create(:merchant)
    @item = create_list(:item, 4, merchant_id: @merchant_1.id)
    @invoice = create_list :invoice, 4
    @invoice_item_1 = create(:invoice_item, status: 0, item: @item[0], invoice: @invoice[0])
    @invoice_item_2 = create(:invoice_item, status: 0, item: @item[1], invoice: @invoice[1])
    @invoice_item_3 = create(:invoice_item, status: 0, item: @item[2], invoice: @invoice[2])
    @invoice_item_4 = create(:invoice_item, status: 0, item: @item[3], invoice: @invoice[3])
    @invoice_2 = create(:invoice)
  end

  it "show items that have not yet been shipped" do
    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_content("Items Ready to Ship")

    expect(page).to have_content(@invoice[0].id)

    expect(page).to have_content(@invoice[1].id)

    expect(page).to have_content(@invoice[2].id)

    expect(page).to have_content(@invoice[3].id)
  end

  # it "show link to merchant show page" do
  #   visit "/merchants/#{@merchant_1.id}/dashboard"
  #   click_link("Invoice ##{@invoice_2.id}")
  #   expect(current_path).to eq("Invoice ##{@invoice_2.id}")
  #   expect(page).to have_content(@invoice_2.date)
  # end

  it "shows merchant name" do
    visit "/merchants/#{@merchant_1.id}/dashboard"
    expect(page).to have_content(@merchant_1.name)
  end

  it "show link to items index" do
    visit "/merchants/#{@merchant_1.id}/dashboard"
    click_link("Items")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
  end

  it "show link to invoices index" do
    visit "/merchants/#{@merchant_1.id}/dashboard"
    click_link("Invoices")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
  end
end
