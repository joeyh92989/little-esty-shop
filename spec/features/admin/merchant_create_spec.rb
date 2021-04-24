require "rails_helper"

RSpec.describe "the admin merchants create" do
  context "given valid data" do
    it "submits the new form and shows disabled merchant" do
      visit "/admin/merchants/new"
      expect(find("form")).to have_content("Name")
      fill_in("Name", with: "Tony Montana")
      click_button "Submit"

      expect(page).to have_current_path("/admin/merchants")
      expect(page).to have_content("Tony Montana: disabled")
    end
  end

  context "given invalid data" do
    it "re-renders the new form" do
      visit "/admin/merchants/new"

      fill_in("Name", with: "")
      click_button "Submit"

      expect(page).to have_current_path("/admin/merchants/new")
      expect(page).to have_content("Error: Name can't be blank")
    end
  end
end
