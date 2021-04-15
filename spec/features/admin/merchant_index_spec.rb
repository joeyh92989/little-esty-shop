require 'rails_helper'

RSpec.describe 'the admin merchants index' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
  end

  it 'lists the names of all merchants in the system' do
    visit "/admin/merchants"

    expect(page).to have_link(@merchant_1.name)
    expect(page).to have_link(@merchant_2.name)
    expect(page).to have_link(@merchant_3.name)
  end

  it 'clicks merchant name and redirects to its show' do
    visit "/admin/merchants"

    click_link "#{@merchant_1.name}"
    expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")

    expect(page).to have_content(@merchant_1.name)
  end
end
