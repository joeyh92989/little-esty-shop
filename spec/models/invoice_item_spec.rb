require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
    it { should belong_to :item }
    it { should have_many(:bulk_discounts).through(:item) } 

  end
  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:quantity) }
  end

  describe 'instance methods' do
    it 'returns the associated the bulk discounts ordered by top discount' do
      merchant = create :merchant
      bulk_discount = create :bulk_discount, threshold: 5, discount: 50, merchant: merchant
      bulk_discount_1 = create :bulk_discount, threshold: 10, discount: 70, merchant: merchant
      item = create_list :item, 3, merchant: merchant
      customer = create :customer

      invoice_1 = create :invoice, customer: customer


      invoice_item_1 = create :invoice_item, quantity: 5, unit_price: 100, invoice: invoice_1, item: item[0]
      invoice_item_2 = create :invoice_item, quantity: 10, unit_price: 100, invoice: invoice_1, item: item[1]
      invoice_item_3 = create :invoice_item, quantity: 1, unit_price: 100, invoice: invoice_1, item: item[2]


      expect(invoice_item_1.applicable_discount).to eq(bulk_discount)
      expect(invoice_item_2.applicable_discount).to eq(bulk_discount_1)
      expect(invoice_item_3.applicable_discount).to eq(nil)

    end
  end
end
