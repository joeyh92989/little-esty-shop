require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }

  end
  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:quantity) }
  end

  describe 'class methods'do
    before :each do
      @merchant = Merchant.create!(name: "Tim")
      @item_1 = @merchant.items.create!(name: "toy car", description: "super fast", unit_price: 5)
      @item_2 = @merchant.items.create!(name: "pack of rubber bands", description: "bouncy", unit_price: 2)
      @item_3 = @merchant.items.create!(name: "toy train", description: "loud", unit_price: 20)
      @item_4 = @merchant.items.create!(name: "ear plugs", description: "soft", unit_price: 7)
      @item_5 = @merchant.items.create!(name: "headphones", description: "quality", unit_price: 100)
      @item_6 = @merchant.items.create!(name: "chair", description: "comfortable", unit_price: 80)

      @cusomer = Customer.create!(first_name: "Austin", last_name: "thinks hes good at games")
      @invoice_1 = Invoice.create!(status: 2, customer: @cusomer)
      @invoice_2 = Invoice.create!(status: 2, customer: @cusomer)
      @invoice_3 = Invoice.create!(status: 2, customer: @cusomer)

      @invoice_item_1 = @invoice_1.invoice_items.create!(item: @item_1, quantity: 1, unit_price: 5, status: 1)
      @invoice_item_1 = @invoice_1.invoice_items.create!(item: @item_2, quantity: 5, unit_price: 2, status: 1)

      @invoice_item_2 = @invoice_2.invoice_items.create!(item: @item_3, quantity: 1, unit_price: 20, status: 1)
      @invoice_item_2 = @invoice_2.invoice_items.create!(item: @item_4, quantity: 2, unit_price: 7, status: 1)
      # invoice_item_3 is shipped and should not show up on list
      @invoice_item_3 = @invoice_3.invoice_items.create!(item: @item_5, quantity: 1, unit_price: 100, status: 2)
      @invoice_item_3 = @invoice_3.invoice_items.create!(item: @item_6, quantity: 1, unit_price: 80, status: 2)
    end
  end
end
