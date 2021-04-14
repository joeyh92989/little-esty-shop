require 'rails_helper'

RSpec.describe 'the admin merchants index' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Mike Brown')
    @merchant_2 = Merchant.create!(name: 'Jessica Thomas')
    @merchant_3 = Merchant.create!(name: 'Ted Karma')
  end

  it 'lists the names of all merchants in the system' do
    visit "/admin/merchants"

    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
  end
end
