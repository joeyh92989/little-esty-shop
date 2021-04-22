require 'rails_helper'

RSpec.describe 'the admin application index' do
  before(:each) do
    @customer = create_list(:customer, 6)
    @invoice_1 = @customer.each{|customer| create :invoice, customer: customer}
    @transaction_1 = create_list :transaction, 10, invoice: @customer[0].invoices.first
    @transaction_2 = create_list :transaction, 10, invoice: @customer[1].invoices.first
    @transaction_3 = create_list :transaction, 10, invoice: @customer[2].invoices.first
    @transaction_4 = create_list :transaction, 10, invoice: @customer[3].invoices.first
    @transaction_5 = create_list :transaction, 10, invoice: @customer[4].invoices.first
    @transaction_6 = create_list :transaction, 10, result: 1, invoice: @customer[5].invoices.first
    @invoice_2 = create_list :invoice, 3
    @invoice_items_1 = create_list :invoice_item, 10, status: 2, invoice: @invoice_2[0]
    @invoice_items_2 = create_list :invoice_item, 10, status: 0, invoice: @invoice_2[1]
    @invoice_items_3 = create_list :invoice_item, 10, status: 1, invoice: @invoice_2[2]
    
  end

  it 'displays admin dashboard ' do
    visit "/admin"

    expect(page).to have_content("Admin")
  end

  it 'has a link to admin merchant path' do
    visit "/admin"

    click_link('Merchant Index')
    expect(current_path).to eq('/admin/merchants') 
  end

  it 'has a link to admin invoice path' do
    visit "/admin"

    click_link('Invoice Index')
    expect(current_path).to eq('/admin/invoices') 
  end
  it 'lists the top 5 customers with their number of succesful transctions' do
    visit "/admin"
    

    expect(page).to_not have_content(@customer[5].first_name)

    within "#customer-#{@customer[0].id}" do
      expect(page).to have_content(@customer[0].first_name)
      expect(page).to have_content(@customer[0].last_name)
      expect(page).to have_content(@customer[0].number_of_succesful_transactions)
    end
    within "#customer-#{@customer[1].id}" do
      expect(page).to have_content(@customer[1].first_name)
      expect(page).to have_content(@customer[1].last_name)
      expect(page).to have_content(@customer[1].number_of_succesful_transactions)

    end
    within "#customer-#{@customer[2].id}" do
      expect(page).to have_content(@customer[2].first_name)
      expect(page).to have_content(@customer[2].last_name)
      expect(page).to have_content(@customer[2].number_of_succesful_transactions)

    end
    within "#customer-#{@customer[3].id}" do
      expect(page).to have_content(@customer[3].first_name)
      expect(page).to have_content(@customer[3].last_name)
      expect(page).to have_content(@customer[3].number_of_succesful_transactions)

    end
    within "#customer-#{@customer[4].id}" do
      expect(page).to have_content(@customer[4].first_name)
      expect(page).to have_content(@customer[4].last_name)
      expect(page).to have_content(@customer[4].number_of_succesful_transactions)

    end
  end
  it 'lists invoices with unshipped items' do
    visit "/admin"
    
    expect(page).to_not have_content(@invoice_2[0].id)

    within "#invoice-#{@invoice_2[1].id}" do
      expect(page).to have_content(@invoice_2[1].id)
      click_link "Invoice-#{@invoice_2[1].id}"
      expect(current_path).to eq("/admin/invoices/#{@invoice_2[1].id}")
    end
  end
end