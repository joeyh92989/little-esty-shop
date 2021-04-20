require 'rails_helper'

RSpec.describe 'merchant items index' do
  before(:each) do
    @merchant = create_list(:merchant, 3)

    @item_1 = create :item, merchant: @merchant[0]
    @item_2 = create :item, merchant: @merchant[1]
    @item_3 = create :item, merchant: @merchant[2]
  end
  it 'displays all items for the merchant as links to show' do
    visit "merchants/#{@merchant[0].id}/items"

    expect(page).to have_link(@item_1.name)
    expect(page).to_not have_content(@item_2.name)
    expect(page).to_not have_content(@item_3.name)
  end

  it "clicks an item and redirects to show" do
    visit "merchants/#{@merchant[0].id}/items"

    click_link(@item_1.name)
    expect(page).to have_current_path("/merchants/#{@merchant[0].id}/items/#{@item_1.id}")
  end
  it 'displys top 5 items with details' do
    item_1 = create :item, merchant: @merchant[0]
    item_2 = create :item, merchant: @merchant[0]
    item_3 = create :item, merchant: @merchant[0]
    item_4 = create :item, merchant: @merchant[0]
    item_5 = create :item, merchant: @merchant[0]
    item_6 = create :item, merchant: @merchant[0]
    invoice = create_list :invoice, 6
    transactions_1= create_list :transaction, 10, result: 1, invoice: invoice.first
    transactions_2= create_list :transaction, 10, result: 0, invoice: invoice.second
    transactions_6= create_list :transaction, 10, invoice: invoice.third
    transactions_3= create_list :transaction, 10, invoice: invoice.fourth
    transactions_4= create_list :transaction, 10, invoice: invoice.fifth
    transactions_5= create_list :transaction, 10, invoice: invoice[5]
    invoice_item_2 = create :invoice_item, item: item_2, invoice: invoice.first
    invoice_item_3 = create :invoice_item, item: item_3, unit_price: 9999999, quantity: 9999999, invoice: invoice.second
    invoice_item_1 = create :invoice_item, item: item_1, invoice: invoice.third
    invoice_item_4 = create :invoice_item, item: item_4, invoice: invoice.fourth
    invoice_item_5 = create :invoice_item, item: item_5, invoice: invoice.fifth
    invoice_item_6 = create :invoice_item, item: item_6, invoice: invoice[5]
    binding.pry
    visit "merchants/#{@merchant[0].id}/items"

    expect(page).to_not have_content(item_2.name)
    expect(item_3.name).to appear_before(item_1.name)

    within "#item-#{item_1.id}" do
      expect(page).to have_link("#{item_1.name}"
    end
    within "#item-#{item_3.id}" do
      expect(page).to have_link("#{item_3.name}")
      expect(page).to have_link("Invoice:#{@merchant.invoices[0].id}")
    end
    within "#item-#{item_4.id}" do
      expect(page).to have_link("#{item_4.name}")
      expect(page).to have_link("Invoice:#{@merchant.invoices[0].id}")
    end
    within "#item-#{item_5.id}" do
      expect(page).to have_link("#{item_5.name}")
      expect(page).to have_link("Invoice:#{@merchant.invoices[0].id}")
    end
    within "#item-#{item_6.id}" do
      expect(page).to have_link("#{item_6.name}")
      expect(page).to have_link("Invoice:#{@merchant.invoices[0].id}")
    end

  end
end
