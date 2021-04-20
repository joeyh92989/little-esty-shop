require 'rails_helper'

RSpec.describe 'merchant items index' do
  before(:each) do
    @merchant = create_list(:merchant, 3)

    @item_1 = create :item, merchant: @merchant[0]
    @item_2 = create :item, merchant: @merchant[1]
    @item_3 = create :item, merchant: @merchant[2]
    @enabled_item = create :item, merchant: @merchant[0], status: "enabled"
  end

  it 'displays all items for the merchant as links to show' do
    visit "merchants/#{@merchant[0].id}/items"

    expect(page).to have_link(@item_1.name)
    expect(page).to_not have_content(@item_2.name)
    expect(page).to_not have_content(@item_3.name)
  end

  it "clicks an item and redirects to show" do
    visit "merchants/#{@merchant[0].id}/items"

    click_link(@item_1.name)
    expect(page).to have_current_path("/merchants/#{@merchant[0].id}/items/#{@item_1.id}")
  end

  it 'displys top 5 items with details' do
    merchant = create :merchant
    item_1 = create :item, merchant: merchant
    item_2 = create :item, merchant: merchant
    item_3 = create :item, merchant: merchant
    item_4 = create :item, merchant: merchant
    item_5 = create :item, merchant: merchant
    item_6 = create :item, merchant: merchant
    invoice = create_list :invoice, 6
    transactions_1= create_list :transaction, 10, result: 1, invoice: invoice.first
    transactions_2= create :transaction, result: 0, invoice: invoice.second
    transactions_6= create :transaction, result: 0, invoice: invoice.third
    transactions_3= create :transaction,result: 0,  invoice: invoice.fourth
    transactions_4= create :transaction, result: 0,  invoice: invoice.fifth
    transactions_5= create :transaction, result: 0, invoice: invoice[5]
    invoice_item_2 = create :invoice_item, item: item_2, invoice: invoice.first
    invoice_item_3 = create :invoice_item, item: item_3, unit_price: 500, quantity: 500, invoice: invoice.second
    invoice_item_1 = create :invoice_item, item: item_1, invoice: invoice.third
    invoice_item_4 = create :invoice_item, item: item_4, invoice: invoice.fourth
    invoice_item_5 = create :invoice_item, item: item_5, invoice: invoice.fifth
    invoice_item_6 = create :invoice_item, item: item_6, invoice: invoice[5]


    visit "merchants/#{merchant.id}/items"
    
    # expect(page).to_not have_content(item_2.name)
    # expect(item_3.name).to appear_before(item_1.name)

    within "#item-#{item_1.id}" do
      expect(page).to have_link(item_1.name)
      expect(page).to have_content(item_1.total_rev)
    end
    within "#item-#{item_3.id}" do
      expect(page).to have_link("#{item_3.name}")
      expect(page).to have_content(item_3.total_rev)
    end
    within "#item-#{item_4.id}" do
      expect(page).to have_link("#{item_4.name}")
      expect(page).to have_content(item_4.total_rev)
    end
    within "#item-#{item_5.id}" do
      expect(page).to have_link("#{item_5.name}")
      expect(page).to have_content(item_5.total_rev)
    end
    within "#item-#{item_6.id}" do
      expect(page).to have_link("#{item_6.name}")
      expect(page).to have_content(item_6.total_rev)
    end
  end
end


  it 'displays enable/disable buttons' do
    visit "/merchants/#{@merchant[0].id}/items"

    expect(page).to have_button('disable')
    expect(page).to have_button('enable')
  end

  context "clicking disabled item's enable button" do
    it 'redirects to index and displays enabled flash message' do
      visit "merchants/#{@merchant[0].id}/items"

      within "#item-#{@item_1.id}" do
        expect(page).to have_button('enable')
        click_button "enable"
      end

      expect(current_path).to eq("/merchants/#{@merchant[0].id}/items")

      within "#item-#{@item_1.id}" do
        expect(page).to have_button('disable')
      end
      expect(page).to have_content("has been enabled!")
    end
  end

  context "clicking enabled merchant's disable button" do
    it 'redirects to index and displays disabled flash message' do
      visit "/merchants/#{@merchant[0].id}/items"

      within "#item-#{@enabled_item.id}" do
        expect(page).to have_button('disable')
        click_button "disable"
      end

      expect(current_path).to eq("/merchants/#{@merchant[0].id}/items")

      within "#item-#{@enabled_item.id}" do
        expect(page).to have_button('enable')
      end

      expect(page).to have_content("has been disabled!")
    end
  end

  it "clicks create link and redirects to create page" do
    visit "/merchants/#{@merchant[0].id}/items"

    expect(page).to have_link('Create New Item')
    click_link 'Create New Item'

    expect(current_path).to eq("/merchants/#{@merchant[0].id}/items/new")
  end
end

