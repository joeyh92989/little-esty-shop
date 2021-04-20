require 'rails_helper'

RSpec.describe 'merchant items show' do
  before(:each) do
    @merchant = create_list(:merchant, 3)

    @item_1 = create :item, merchant: @merchant[0]
    @item_2 = create :item, merchant: @merchant[1]
    @item_3 = create :item, merchant: @merchant[2]
  end

  it "displays item attributes" do
    visit "/merchants/#{@merchant[0].id}/items/#{@item_1.id}"

    expect(page).to have_content("Name: #{@item_1.name}")
    expect(page).to have_content("Description: #{@item_1.description}")
    expect(page).to have_content("Current Selling Price: #{@item_1.unit_price}")

    expect(page).to_not have_content(@item_2.name)
  end

  it "clicks update link and redirects to edit page" do
    visit "/merchants/#{@merchant[0].id}/items/#{@item_1.id}"

    expect(page).to have_link("Update")
    click_link "Update"

    expect(page).to have_current_path("/merchants/#{@merchant[0].id}/items/#{@item_1.id}/edit")
  end
end
