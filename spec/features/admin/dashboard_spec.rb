require 'rails_helper'

RSpec.describe 'the admin application- show' do
  # before(:each) do
  # end

  it 'displays admin dashboard ' do
    visit "/admin"

    expect(page).to have_content("Admin")
  end
end