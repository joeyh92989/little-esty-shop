require "rails_helper"

RSpec.describe "merchant dashboard" do
  before :each do
    @merchant_1 = create(:merchant)
    @bulk_discount = create_list :bulk_discount, 3, merchant: @merchant_1
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

    @holiday = (DateService.new).holidays
    visit "/merchants/#{@merchant_1.id}/bulk_discounts"
  end

  it "lists all bulk_discounts" do
    

    expect(page).to have_content("Bulk Discounts")

    within "#bulk_discount-#{@bulk_discount[0].id}" do
      expect(page).to have_link("#{@bulk_discount[0].name}")
      expect(page).to have_content(@bulk_discount[0].threshold)
      expect(page).to have_content(@bulk_discount[0].discount)
    end
    within "#bulk_discount-#{@bulk_discount[1].id}" do
      expect(page).to have_link("#{@bulk_discount[1].name}")
      expect(page).to have_content(@bulk_discount[1].threshold)
      expect(page).to have_content(@bulk_discount[1].discount)
    end
    within "#bulk_discount-#{@bulk_discount[2].id}" do
      expect(page).to have_link("#{@bulk_discount[2].name}")
      expect(page).to have_content(@bulk_discount[2].threshold)
      expect(page).to have_content(@bulk_discount[2].discount)
    end
  end
  it "lists the upcoming holidays" do
      expect(page).to have_content("Upcoming Holidays")

      expect(page).to have_content("Name: #{@holiday[0][:name]}")
      expect(page).to have_content("Date: #{@holiday[0][:date]}")
      expect(page).to have_content("Name: #{@holiday[1][:name]}")
      expect(page).to have_content("Date: #{@holiday[1][:date]}")
      expect(page).to have_content("Name: #{@holiday[2][:name]}")
      expect(page).to have_content("Date: #{@holiday[2][:date]}")

  end
end
