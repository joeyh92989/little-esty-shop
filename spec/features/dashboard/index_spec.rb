require 'rails_helper'


RSpec.describe 'merchant dashboard' do
  before :each do
    @merchant_1 = create(:merchant)
    @item = create_list(:item, 6, merchant: @merchant_1)

    @invoice = create_list(:invoice, 6)
    @customer_1 = @invoice[0].customer
    @customer_2 = @invoice[1].customer
    @customer_3 = @invoice[2].customer
    @customer_4 = @invoice[3].customer
    @customer_5 = @invoice[4].customer
    @customer_6 = @invoice[5].customer

    @invoice_item_1 = create(:invoice_item, item: @item[0], invoice: @invoice[0])
    @invoice_item_2 = create(:invoice_item, item: @item[1], invoice: @invoice[1])
    @invoice_item_3 = create(:invoice_item, item: @item[2], invoice: @invoice[2])
    @invoice_item_4 = create(:invoice_item, item: @item[3], invoice: @invoice[3])
    @invoice_item_5 = create(:invoice_item, item: @item[4], invoice: @invoice[4])
    @invoice_item_6 = create(:invoice_item, item: @item[5], invoice: @invoice[5])

    @transaction_1 = create_list(:transaction, 20, invoice: @invoice[0])
    @transaction_2 = create_list(:transaction, 15, invoice: @invoice[1])
    @transaction_3 = create_list(:transaction, 10, invoice: @invoice[2])
    @transaction_4 = create_list(:transaction, 7, invoice: @invoice[3])
    @transaction_5 = create_list(:transaction, 5, invoice: @invoice[4])
    @transaction_6 = create_list(:transaction, 3, invoice: @invoice[5])

    visit "/merchants/#{@merchant_1.id}/dashboard"
  end

  it "shows merchant name" do
    expect(page).to have_content(@merchant_1.name)
  end

  it "show link to items index" do
    click_link("Items")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
  end

  it "show link to invoices index" do
    click_link("Invoices")
    expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
  end

  it "shows names of the top 5 customers by successful transactions" do
    expect(@customer_1.first_name).to appear_before(@customer_2.first_name)
    expect(@customer_3.first_name).to appear_before(@customer_4.first_name)
  end
end
