require 'rails_helper'

RSpec.describe 'the admin invoice show' do
  before(:each) do
    @invoice= create :invoice
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
end