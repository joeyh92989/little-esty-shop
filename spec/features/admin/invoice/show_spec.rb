require 'rails_helper'

RSpec.describe 'the admin invoice show' do
  before(:each) do
    @invoice= create :invoice
    @invoice_items = create_list :invoice_item, 5, invoice: @invoice
  end

  it 'admin invoice show ' do
    visit "/admin/invoices/#{@invoice.id}"

    expect(page).to have_content("Admin Invoice Show")

    within "#invoice-#{@invoice.id}" do
      expect(page).to have_content(@invoice.id)
      expect(page).to have_content(@invoice.status)
      expect(page).to have_content(@invoice.created_at.to_time.strftime(' %A, %B %e, %Y'))
      expect(page).to have_content(@invoice.customer.first_name)
      expect(page).to have_content(@invoice.customer.last_name)
    end
  end
  it 'displays the total revenue within the admin invoice show ' do
    visit "/admin/invoices/#{@invoice.id}"


    within "#invoice-#{@invoice.id}" do
      expect(page).to have_content(@invoice.total_revenue)
      
    end
  end
  it 'displays the invoice item details' do
    visit "/admin/invoices/#{@invoice.id}"


    within "#invoice-item-#{@invoice_items[0].id}" do
      expect(page).to have_content(@invoice_items[0].item.name)
      expect(page).to have_content(@invoice_items[0].quantity)
      expect(page).to have_content(@invoice_items[0].unit_price)
      expect(page).to have_content(@invoice_items[0].status)
    end
    within "#invoice-item-#{@invoice_items[1].id}" do
      expect(page).to have_content(@invoice_items[1].item.name)
      expect(page).to have_content(@invoice_items[1].quantity)
      expect(page).to have_content(@invoice_items[1].unit_price)
      expect(page).to have_content(@invoice_items[1].status)
    end
    within "#invoice-item-#{@invoice_items[2].id}" do
      expect(page).to have_content(@invoice_items[2].item.name)
      expect(page).to have_content(@invoice_items[2].quantity)
      expect(page).to have_content(@invoice_items[2].unit_price)
      expect(page).to have_content(@invoice_items[2].status)
    end
    within "#invoice-item-#{@invoice_items[3].id}" do
      expect(page).to have_content(@invoice_items[3].item.name)
      expect(page).to have_content(@invoice_items[3].quantity)
      expect(page).to have_content(@invoice_items[3].unit_price)
      expect(page).to have_content(@invoice_items[3].status)
    end
    within "#invoice-item-#{@invoice_items[4].id}" do
      expect(page).to have_content(@invoice_items[4].item.name)
      expect(page).to have_content(@invoice_items[4].quantity)
      expect(page).to have_content(@invoice_items[4].unit_price)
      expect(page).to have_content(@invoice_items[4].status)
    end
  end
  it 'has a drop down selector for invoice status and allows user to update the value ' do
    invoice= create :invoice, status: 2
    visit "/admin/invoices/#{invoice.id}"

    within "#invoice-#{invoice.id}" do
      expect(page).to have_field('status', with: "#{invoice.status}")
      page.select 'completed', from: 'status'
      click_button 'Save'
    end
    within "#invoice-#{invoice.id}" do
      expect(page).to have_content('completed')
    end
  end
    it 'displays the total rev with discounts' do
      merchant = create(:merchant)
      bulk_discount = create :bulk_discount , threshold: 5
      customer = create(:customer)
      item_1 = create_list :item, 10, merchant: merchant
      invoice_2 = create :invoice
      invoice_items_1 = create :invoice_item, quantity: 5, invoice: invoice_2, item: item_1.first
      transaction_1 = create_list :transaction, 10, invoice: merchant.invoices.first
  
      merchant_invoices = merchant.invoices.uniq
      invoice_items = merchant_invoices.first.invoice_items
      visit "/admin/invoices/#{invoice_2.id}"

      within "#invoice-#{invoice_2.id}" do
        expect(page).to have_content(invoice_2.total_rev_with_discounts)
      end
    end
end