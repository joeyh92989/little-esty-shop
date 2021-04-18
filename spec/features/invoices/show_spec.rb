require 'rails_helper'

RSpec.describe 'the merchant invoice show' do
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

  it 'merchant invoice show ' do
    visit "/merchants/#{@merchant.id}/invoices/#{@merchant_invoices.first.id})"

    expect(page).to have_content("Merchant Invoice Show")

    within "#invoice-#{@merchant_invoices.first.id}" do
      expect(page).to have_content(@merchant_invoices.first.id)
      expect(page).to have_content(@merchant_invoices.first.status)
      expect(page).to have_content(@merchant_invoices.first.created_at.to_time.strftime(' %A, %B %e, %Y'))
      expect(page).to have_content(@merchant_invoices.first.customer.first_name)
      expect(page).to have_content(@merchant_invoices.first.customer.last_name)
    end
  end
  # it 'displays the total revenue within the admin invoice show ' do
  #   visit "/admin/invoices/#{@invoice.id}"


  #   within "#invoice-#{@invoice.id}" do
  #     expect(page).to have_content(@invoice.total_revenue)
      
  #   end
  # end
  # it 'displays the invoice item details' do
  #   visit "/admin/invoices/#{@invoice.id}"


  #   within "#invoice-item-#{@invoice_items[0].id}" do
  #     expect(page).to have_content(@invoice_items[0].item.name)
  #     expect(page).to have_content(@invoice_items[0].quantity)
  #     expect(page).to have_content(@invoice_items[0].unit_price)
  #     expect(page).to have_content(@invoice_items[0].status)
  #   end
  #   within "#invoice-item-#{@invoice_items[1].id}" do
  #     expect(page).to have_content(@invoice_items[1].item.name)
  #     expect(page).to have_content(@invoice_items[1].quantity)
  #     expect(page).to have_content(@invoice_items[1].unit_price)
  #     expect(page).to have_content(@invoice_items[1].status)
  #   end
  #   within "#invoice-item-#{@invoice_items[2].id}" do
  #     expect(page).to have_content(@invoice_items[2].item.name)
  #     expect(page).to have_content(@invoice_items[2].quantity)
  #     expect(page).to have_content(@invoice_items[2].unit_price)
  #     expect(page).to have_content(@invoice_items[2].status)
  #   end
  #   within "#invoice-item-#{@invoice_items[3].id}" do
  #     expect(page).to have_content(@invoice_items[3].item.name)
  #     expect(page).to have_content(@invoice_items[3].quantity)
  #     expect(page).to have_content(@invoice_items[3].unit_price)
  #     expect(page).to have_content(@invoice_items[3].status)
  #   end
  #   within "#invoice-item-#{@invoice_items[4].id}" do
  #     expect(page).to have_content(@invoice_items[4].item.name)
  #     expect(page).to have_content(@invoice_items[4].quantity)
  #     expect(page).to have_content(@invoice_items[4].unit_price)
  #     expect(page).to have_content(@invoice_items[4].status)
  #   end
  # end
  # it 'has a drop down selector for invoice status and allows user to update the value ' do
  #   invoice= create :invoice, status: 2
  #   visit "/admin/invoices/#{invoice.id}"
  #   save_and_open_page

  #   within "#invoice-#{invoice.id}" do
  #     expect(page).to have_field('status', with: "#{invoice.status}")
  #     page.select 'completed', from: 'status'
  #     click_button 'Save'
  #   end
  #   within "#invoice-#{invoice.id}" do
  #     expect(page).to have_content('completed')
  #   end
  # end
end