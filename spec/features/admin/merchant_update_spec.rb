require 'rails_helper'

RSpec.describe 'the admin merchants update' do
  before(:each) do
    @merchant_1 = create(:merchant)
  end


  it 'renders prefilled form ' do
    visit "/admin/merchants/#{@merchant_1.id}/edit"

    expect(find('form')).to have_content('Name')
    expect(page).to have_field('Name', with: "#{@merchant_1.name}")
  end

  context "given valid data" do
    it "submits the edit form and updates the merchant" do
      visit "/admin/merchants/#{@merchant_1.id}/edit"

      fill_in('Name', with: 'Joey Haandsome')
      click_button("submit")

      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")

      expect(page).to have_content("successfully updated!")
      expect(page).to_not have_content("#{@merchant_1.name}")
      expect(page).to_not have_content('Mike Brown')
    end
  end

  context "given invalid data" do
    it 're-renders the edit form' do
      visit "/admin/merchants/#{@merchant_1.id}/edit"

      fill_in 'Name', with: ''
      click_button 'submit'

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/admin/merchants/#{@merchant_1.id}/edit")
    end
  end
end
