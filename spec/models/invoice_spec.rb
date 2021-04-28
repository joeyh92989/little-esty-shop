require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:bulk_discounts).through(:invoice_items) }
  end
  describe 'validations' do
    it { should validate_presence_of(:status) }

  end
  before(:each) do
    @merchant = create :merchant
    @bulk_discount = create :bulk_discount, threshold: 5, discount: 0.5, merchant: @merchant

    
    @invoice = create_list :invoice, 3

    @invoice_items_1 = create_list :invoice_item, 10, status: 2, invoice: @invoice[0]
    @invoice_items_2 = create_list :invoice_item, 10, status: 0, invoice: @invoice[1]
    @invoice_items_3 = create_list :invoice_item, 10, status: 1, invoice: @invoice[2]
    

  end
  describe '::class methods' do
    it 'returns invoices with unshipped items' do
      expect(Invoice.unshipped).to contain_exactly(@invoice[1],@invoice[2])
    end
  end
  describe '#instance methods' do
    it 'returns total revenue' do
      invoice_1 = create :invoice
      invoice_item_1 = create :invoice_item, quantity: 5, unit_price: 100, invoice: invoice_1
      invoice_item_2 = create :invoice_item, quantity: 10, unit_price: 100, invoice: invoice_1
      invoice_item_3 = create :invoice_item, quantity: 1, unit_price: 100, invoice: invoice_1
      expect(invoice_1.total_revenue).to eq(1600)
    end
    
    it 'returns discount rev diff' do
      merchant = create :merchant
      bulk_discount = create :bulk_discount, threshold: 5, discount: 50, merchant: merchant
      bulk_discount_1 = create :bulk_discount, threshold: 10, discount: 70, merchant: merchant
      item = create_list :item, 3, merchant: merchant
      customer = create :customer
      invoice_1 = create :invoice, customer: customer
      invoice_item_1 = create :invoice_item, quantity: 5, unit_price: 100, invoice: invoice_1, item: item[0]
      invoice_item_2 = create :invoice_item, quantity: 10, unit_price: 100, invoice: invoice_1, item: item[1]
      invoice_item_3 = create :invoice_item, quantity: 1, unit_price: 100, invoice: invoice_1, item: item[2]

      expect(invoice_1.discounted_rev).to eq(550)
    end

    it 'returns total  rev with discounts' do
      merchant = create :merchant
      bulk_discount = create :bulk_discount, threshold: 5, discount: 50, merchant: merchant
      bulk_discount_1 = create :bulk_discount, threshold: 10, discount: 70, merchant: merchant
      item = create_list :item, 3, merchant: merchant
      customer = create :customer
      customer_2 = create :customer
      invoice_1 = create :invoice, customer: customer
      invoice_2 = create :invoice, customer: customer_2

      invoice_item_1 = create :invoice_item, quantity: 5, unit_price: 100, invoice: invoice_1, item: item[0]
      invoice_item_2 = create :invoice_item, quantity: 10, unit_price: 100, invoice: invoice_1, item: item[1]
      invoice_item_3 = create :invoice_item, quantity: 1, unit_price: 100, invoice: invoice_1, item: item[2]
      invoice_item_1 = create :invoice_item, quantity: 1, unit_price: 100, invoice: invoice_2, item: item[0]
      invoice_item_2 = create :invoice_item, quantity: 1, unit_price: 100, invoice: invoice_2, item: item[1]
      invoice_item_3 = create :invoice_item, quantity: 1, unit_price: 100, invoice: invoice_2, item: item[2]

      expect(invoice_1.total_rev_with_discounts).to eq(1050)
      expect(invoice_2.total_rev_with_discounts).to eq(300)
    end
  end
end

