require "rails_helper"

RSpec.describe "bulk discount create " do
  before :each do
    @merchant_1 = create(:merchant)
    @item = create_list(:item, 6, merchant: @merchant_1)

    visit "/merchants/#{@merchant_1.id}/bulk_discounts/new"
  end

  it "lists all fields in the create form" do
    expect(page).to have_content('New Bulk Discount')
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Threshold')
    expect(find('form')).to have_content('Discount')
  end

  it 'creates the bulk discount and redirects to the merchants bulk discount index' do
    visit "/merchants/#{@merchant_1.id}/bulk_discounts/new"

    fill_in 'Name', with: 'Big Discount'
    fill_in 'Threshold', with: 10
    fill_in 'Discount', with: 50
    click_button 'Save'
    expect(page).to have_current_path("/merchants/#{@merchant_1.id}/bulk_discounts")
    expect(page).to have_content('Big Discount')
  end
  it 're-renders the new form after error' do
    
    visit "/merchants/#{@merchant_1.id}/bulk_discounts/new"

    click_button 'Save'

    expect(page).to have_current_path("/merchants/#{@merchant_1.id}/bulk_discounts/new")
    expect(page).to have_content("Error: Name can't be blank, Threshold can't be blank, Threshold is not a number, Threshold is not a number, Discount can't be blank, Discount is not a number, Discount is not a number")
  end
end