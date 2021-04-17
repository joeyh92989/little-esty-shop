require 'rails_helper'

RSpec.describe 'the admin invoice index' do
  before(:each) do
    @invoice= create_list :invoice, 3
  end

  it 'admin invoice index ' do
    visit "/admin/invoices"

    expect(page).to have_content("Admin Invoices")

    within "#invoice-#{@invoice[0].id}" do
      expect(page).to have_content(@invoice[0].id)
      expect(page).to have_link("Invoice:#{@invoice[0].id}")
    end
    within "#invoice-#{@invoice[1].id}" do
      expect(page).to have_content(@invoice[1].id)
      expect(page).to have_link("Invoice:#{@invoice[1].id}")
    end
    within "#invoice-#{@invoice[2].id}" do
      expect(page).to have_content(@invoice[2].id)
      expect(page).to have_link("Invoice:#{@invoice[2].id}")
    end
  end
end