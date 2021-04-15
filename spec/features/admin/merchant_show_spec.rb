require 'rails_helper'

RSpec.describe 'the admin merchants show' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Mike Brown')
  end

    it 'renders an update button' do
      visit "/admin/merchants/#{@merchant_1.id}"

      expect(page).to have_button("update")
    end

    it 'clicks update button and redirects to edit page' do
      visit "/admin/merchants/#{@merchant_1.id}"

      click_button("update")
      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}/edit")
    end
end
