require 'rails_helper'

RSpec.describe 'merchant items index' do
  before(:each) do
    @merchant = create_list(:merchant, 3)

    @item_1 = create :item, merchant: @merchant[0]
    @item_2 = create :item, merchant: @merchant[1]
    @item_3 = create :item, merchant: @merchant[2]
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
end
