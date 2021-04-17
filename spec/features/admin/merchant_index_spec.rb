require 'rails_helper'

RSpec.describe 'the admin merchants index' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant, status: "disabled")
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

  it 'displays enable/disable buttons' do
    visit "/admin/merchants"

    expect(page).to have_button('disable')
    expect(page).to have_button('enable')
  end

  context "clicking first enable button" do
    it 'redirects to index and displays enabled flash message' do
      visit "/admin/merchants"

      within "#merchant-#{@merchant_1.id}" do
        expect(page).to have_button('disable')
        click_button "disable"
      end

      expect(current_path).to eq("/admin/merchants")

      within "#merchant-#{@merchant_1.id}" do
        expect(page).to have_button('enable')
      end

      expect(page).to have_content("has been disabled!")
    end
  end

  context "clicking first disable button" do
    it 'redirects to index and displays disabled flash message' do
      visit "/admin/merchants"

      within "#merchant-#{@merchant_4.id}" do
        expect(page).to have_button('enable')
        click_button "enable"
      end

      expect(current_path).to eq("/admin/merchants")

      within "#merchant-#{@merchant_4.id}" do
        expect(page).to have_button('disable')
      end

      expect(page).to have_content("has been enabled!")
    end
  end

  it "clicks create link and redirects to create page" do
    visit "/admin/merchants"

    expect(page).to have_link('Create New Merchant')
    click_link 'Create New Merchant'

    expect(current_path).to eq("/admin/merchants/new")
  end
end
