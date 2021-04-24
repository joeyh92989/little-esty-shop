require "rails_helper"

RSpec.describe "merchant dashboard" do
  before :each do
    @merchant_1 = create(:merchant)
    @item = create_list(:item, 6, merchant: @merchant_1)

    @invoice_1 = create(:invoice, created_at: Time.new(2000, 5, 10))
    @invoice_2 = create(:invoice, created_at: Time.new(2002, 6, 11))
    @invoice_3 = create(:invoice)
    @invoice_4 = create(:invoice)
    @invoice_5 = create(:invoice)
    @invoice_6 = create(:invoice)
    @customer_1 = @invoice_1.customer
    @customer_2 = @invoice_2.customer
    @customer_3 = @invoice_3.customer
    @customer_4 = @invoice_4.customer
    @customer_5 = @invoice_5.customer
    @customer_6 = @invoice_6.customer

    @invoice_item_1 = create(:invoice_item, status: 1, item: @item[0], invoice: @invoice_1)
    @invoice_item_2 = create(:invoice_item, status: 1, item: @item[1], invoice: @invoice_2)
    @invoice_item_3 = create(:invoice_item, status: 1, item: @item[2], invoice: @invoice_3)
    @invoice_item_4 = create(:invoice_item, status: 2, item: @item[3], invoice: @invoice_4)
    @invoice_item_5 = create(:invoice_item, status: 2, item: @item[4], invoice: @invoice_5)
    @invoice_item_6 = create(:invoice_item, status: 2, item: @item[5], invoice: @invoice_6)

    @transaction_1 = create_list(:transaction, 20, result: 0, invoice: @invoice_1)
    @transaction_2 = create_list(:transaction, 15, result: 0, invoice: @invoice_2)
    @transaction_3 = create_list(:transaction, 10, result: 0, invoice: @invoice_3)
    @transaction_4 = create_list(:transaction, 7, result: 0, invoice: @invoice_4)
    @transaction_5 = create_list(:transaction, 5, result: 0, invoice: @invoice_5)
    @transaction_6 = create_list(:transaction, 3, result: 1, invoice: @invoice_6)

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

  it "should show invoice id as link" do
    expect(page).to have_link("#{@invoice_1.id}")
  end

  it "show a section called items ready to ship" do
    expect(page).to have_content("Items Ready to Ship")
  end

  it "shows invoices ordered from oldest to newest by creation" do
    expect(@invoice_1.date).to appear_before(@invoice_2.date)
  end
end
