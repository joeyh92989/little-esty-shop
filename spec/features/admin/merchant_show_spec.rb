require 'rails_helper'

RSpec.describe 'the admin merchants show' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Mike Brown')
  end

  it 'clicks merchant name and redirects to its show' do
    visit "/admin/merchants"

    click_link "#{@merchant_1.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")

    expect(page).to have_content(@merchant_1.name)
  end
end
