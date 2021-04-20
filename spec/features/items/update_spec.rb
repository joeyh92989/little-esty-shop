require 'rails_helper'

RSpec.describe 'merchant items edit' do
  before(:each) do
    @merchant = create_list(:merchant, 3)

    @item_1 = create :item, merchant: @merchant[0]
    @item_2 = create :item, merchant: @merchant[1]
    @item_3 = create :item, merchant: @merchant[2]
  end

  it "renders edit form prefilled" do
    visit "/merchants/#{@merchant[0].id}/items/#{@item_1.id}/edit"

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Description')
    expect(find('form')).to have_content('Unit price')

    expect(page).to have_field('Name', with: "#{@item_1.name}")
    expect(page).to have_field('Description', with: "#{@item_1.description}")
    expect(page).to have_field('Unit price', with: "#{@item_1.unit_price}")
  end

  context "given valid data" do
    it "submits the edit form and updates the item" do
      visit "/merchants/#{@merchant[0].id}/items/#{@item_1.id}/edit"

      fill_in('Name', with: 'Joey Haandsome')
      click_button("submit")

      expect(current_path).to eq("/merchants/#{@merchant[0].id}/items/#{@item_1.id}")

      expect(page).to have_content("successfully updated!")
      expect(page).to_not have_content("#{@item_1.name}")
    end
  end

  context "given invalid data" do
    it 're-renders the edit form' do
      visit "/merchants/#{@merchant[0].id}/items/#{@item_1.id}/edit"

      fill_in 'Name', with: ''
      click_button 'submit'

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/merchants/#{@merchant[0].id}/items/#{@item_1.id}/edit")
    end
  end
end
