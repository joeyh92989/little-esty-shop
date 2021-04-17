require 'rails_helper'

RSpec.describe 'the admin invoice show' do
  before(:each) do
    @invoice= create :invoice
    @invoice_items = create_list :invoice_items, 10, invoice: @invoice
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
end