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
    # And I see a form filled in with the existing item attribute information
    # When I update the information in the form and I click ‘submit’
    # Then I am redirected back to the item show page where I see the updated information
    # And I see a flash message stating that the information has been successfully updated.
  end
end
