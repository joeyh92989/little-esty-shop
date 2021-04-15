require 'rails_helper'

RSpec.describe 'the admin application index' do
  # before(:each) do
  # end

  it 'displays admin dashboard ' do
    visit "/admin"

    expect(page).to have_content("Admin")
  end

  it 'has a link to admin merchant path' do
    visit "/admin"

    click_link('Merchant Index')
    expect(current_path).to eq('/admin/merchants') 
  end
end