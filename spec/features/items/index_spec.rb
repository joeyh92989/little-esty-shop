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
end
