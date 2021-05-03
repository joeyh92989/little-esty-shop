require "rails_helper"

RSpec.describe "the admin merchants index" do
  before(:each) do
    @merchant = create_list(:merchant, 6)
    @customer = create_list(:customer, 6)
    @enabled_merchant = create(:merchant, status: "enabled")
    @item_1 = @merchant.each { |merchant| create :item, merchant: merchant }
    @invoice_1 = @customer.each { |customer| create :invoice, customer: customer }

    @invoice_2 = create_list :invoice, 6

    @invoice_items_1 = create_list :invoice_item, 10, status: 0, invoice: @invoice_2[0], item: @item_1[0].items.first
    @invoice_items_2 = create_list :invoice_item, 10, status: 0, invoice: @invoice_2[1], item: @item_1[1].items.first
    @invoice_items_3 = create_list :invoice_item, 10, status: 0, invoice: @invoice_2[2], item: @item_1[2].items.first
    @invoice_items_4 = create_list :invoice_item, 10, status: 0, invoice: @invoice_2[3], item: @item_1[3].items.first
    @invoice_items_5 = create_list :invoice_item, 10, status: 0, invoice: @invoice_2[4], item: @item_1[4].items.first
    @invoice_items_6 = create_list :invoice_item, 10, status: 2, invoice: @invoice_2[5], item: @item_1[5].items.first

    @transaction_1 = create_list :transaction, 10, invoice: @merchant[0].invoices.first
    @transaction_2 = create_list :transaction, 10, invoice: @merchant[1].invoices.first
    @transaction_3 = create_list :transaction, 10, invoice: @merchant[2].invoices.first
    @transaction_4 = create_list :transaction, 10, invoice: @merchant[3].invoices.first
    @transaction_5 = create_list :transaction, 10, invoice: @merchant[4].invoices.first
    @transaction_6 = create_list :transaction, 10, result: 1, invoice: @merchant[5].invoices.first
  end

  it "lists the names of all merchants in the system" do
    visit "/admin/merchants"

    expect(page).to have_link(@merchant[0].name)
    expect(page).to have_link(@merchant[1].name)
    expect(page).to have_link(@merchant[2].name)
  end

  it "clicks merchant name and redirects to its show" do
    visit "/admin/merchants"

    within "#disabled_merchants" do
      click_link "#{@merchant[0].name}"
    end

    expect(current_path).to eq("/admin/merchants/#{@merchant[0].id}")
    expect(page).to have_content(@merchant[0].name)
  end

  it "displays enable/disable buttons" do
    visit "/admin/merchants"

    expect(page).to have_button("disable")
    expect(page).to have_button("enable")
  end

  context "clicking disabled merchant's enable button" do
    it "redirects to index and displays enabled flash message" do
      visit "/admin/merchants"

      within "#merchant-#{@merchant[0].id}" do
        expect(page).to have_button("enable")
        click_button "enable"
      end

      expect(current_path).to eq("/admin/merchants")

      within "#merchant-#{@merchant[0].id}" do
        expect(page).to have_button("disable")
      end
      expect(page).to have_content("has been enabled!")
    end
  end

  context "clicking enabled merchant's disable button" do
    it "redirects to index and displays disabled flash message" do
      visit "/admin/merchants"

      within "#merchant-#{@enabled_merchant.id}" do
        expect(page).to have_button("disable")
        click_button "disable"
      end

      expect(current_path).to eq("/admin/merchants")

      within "#merchant-#{@enabled_merchant.id}" do
        expect(page).to have_button("enable")
      end

      expect(page).to have_content("has been disabled!")
    end
  end

  it "clicks create link and redirects to create page" do
    visit "/admin/merchants"

    expect(page).to have_link("Create New Merchant")
    click_link "Create New Merchant"

    expect(current_path).to eq("/admin/merchants/new")
  end

  it "lists the top 5 merchants with their total revenue generated and top day" do
    visit "/admin/merchants"

    within "#top_merchants" do
      expect(page).to_not have_content(@merchant[5].name)
    end

    within "#top_merchant-#{@merchant[0].id}" do
      expect(page).to have_link(@merchant[0].name)
      expect(page).to have_content(@merchant[0].total_revenue)
      # expect(page).to have_content("Top selling date for #{@merchant[0].name} was#{@merchant[0].top_merchant_best_day.to_time.strftime(" %A, %B %e, %Y")}")
    end

    within "#top_merchant-#{@merchant[1].id}" do
      expect(page).to have_link(@merchant[1].name)
      expect(page).to have_content(@merchant[1].total_revenue)
      # expect(page).to have_content("Top selling date for #{@merchant[1].name} was#{@merchant[1].top_merchant_best_day.to_time.strftime(" %A, %B %e, %Y")}")
    end

    within "#top_merchant-#{@merchant[2].id}" do
      expect(page).to have_link(@merchant[2].name)
      expect(page).to have_content(@merchant[2].total_revenue)
      # expect(page).to have_content("Top selling date for #{@merchant[2].name} was#{@merchant[2].top_merchant_best_day.to_time.strftime(" %A, %B %e, %Y")}")
    end

    within "#top_merchant-#{@merchant[3].id}" do
      expect(page).to have_link(@merchant[3].name)
      expect(page).to have_content(@merchant[3].total_revenue)
      # expect(page).to have_content("Top selling date for #{@merchant[3].name} was#{@merchant[3].top_merchant_best_day.to_time.strftime(" %A, %B %e, %Y")}")
    end

    within "#top_merchant-#{@merchant[4].id}" do
      expect(page).to have_link(@merchant[4].name)
      expect(page).to have_content(@merchant[4].total_revenue)
      # expect(page).to have_content("Top selling date for #{@merchant[4].name} was#{@merchant[4].top_merchant_best_day.to_time.strftime(" %A, %B %e, %Y")}")
    end
  end
end
