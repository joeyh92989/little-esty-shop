require 'rails_helper'

RSpec.describe 'the merchant invoice index' do
  before(:each) do
    @merchant = create(:merchant)
    @customer = create_list(:customer, 6)
    @item_1 = create_list :item, 10, merchant: @merchant
    @invoice_2 = create :invoice
    @invoice_items_1 = create_list :invoice_item, 3, invoice: @invoice_2, item: @item_1.first
    @invoice_items_2 = create_list :invoice_item, 3, invoice: @invoice_2, item: @item_1.second
    @invoice_items_3 = create_list :invoice_item, 3, invoice: @invoice_2, item: @item_1.third
    @transaction_1 = create_list :transaction, 10, invoice: @merchant.invoices.first
    @transaction_2 = create_list :transaction, 10, invoice: @merchant.invoices.second
    @transaction_3 = create_list :transaction, 10, invoice: @merchant.invoices.third
    @merchant_invoices = @merchant.invoices.uniq
  end

  it 'merchant invoice index ' do
    visit "/merchants/#{@merchant.id}/invoices"

    expect(page).to have_content("Merchant Invoices")

    within "#invoice-#{@merchant_invoices[0].id}" do
      expect(page).to have_content(@merchant.invoices[0].id)
      expect(page).to have_link("Invoice:#{@merchant.invoices[0].id}")
    end
  end
end