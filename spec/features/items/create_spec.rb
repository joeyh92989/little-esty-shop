require 'rails_helper'

RSpec.describe 'merchant items create' do
  before(:each) do
    @merchant = create_list(:merchant, 3)

    @item_1 = create :item, merchant: @merchant[0]
    @item_2 = create :item, merchant: @merchant[1]
    @item_3 = create :item, merchant: @merchant[2]
    @enabled_item = create :item, merchant: @merchant[0], status: "enabled"
  end

  context "given valid data" do
    it "submits the new form and shows disabled item" do
      visit "/merchants/#{@merchant[0].id}/items/new"
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Description')
      expect(find('form')).to have_content('Unit price')
      fill_in('Name', with: 'Bobi')
      fill_in('Description', with: 'Dont mess with him')
      fill_in('Unit price', with: 3456)
      click_button 'submit'

      expect(page).to have_current_path("/merchants/#{@merchant[0].id}/items")
      expect(page).to have_content('Bobi: disabled')
    end
  end

  context "given invalid data" do
    it "re-renders the new form" do
      visit "/merchants/#{@merchant[0].id}/items/new"

      fill_in('Name', with: '')
      click_button 'submit'

      expect(page).to have_current_path("/merchants/#{@merchant[0].id}/items/new")
      expect(page).to have_content("Error: Name can't be blank")
    end
  end
end
