require 'rails_helper'


RSpec.describe 'merhcant dashboard' do
  it "shows merhchant name" do
    merchant_1 = create(:merchant)

    visit "/merchants/#{merchant_1.id}/dashboard"

    expect(page).to have_content(merchant_1.name)
  end
end
