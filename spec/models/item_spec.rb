require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }

  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:merchant_id) }
  end
  before(:each) do
    @item_1 = create :item
    @item_2 = create :item
    @item_3 = create :item
    @item_4 = create :item
    @item_5 = create :item
    @item_6 = create :item
    @invoice = create_list :invoice, 6
    @transactions_1= create_list :transaction, 10, result: 1, invoice: @invoice.first
    @transactions_2= create_list :transaction, 10, result: 0, invoice: @invoice.second
    @transactions_6= create_list :transaction, 10, invoice: @invoice.third
    @transactions_3= create_list :transaction, 10, invoice: @invoice.fourth
    @transactions_4= create_list :transaction, 10, invoice: @invoice.fifth
    @transactions_5= create_list :transaction, 10, invoice: @invoice[5]
    @invoice_item_2 = create :invoice_item, item: @item_2, invoice: @invoice.first
    @invoice_item_3 = create :invoice_item, item: @item_3, invoice: @invoice.second
    @invoice_item_1 = create :invoice_item, item: @item_1, invoice: @invoice.third
    @invoice_item_4 = create :invoice_item, item: @item_4, invoice: @invoice.fourth
    @invoice_item_5 = create :invoice_item, item: @item_5, invoice: @invoice.fifth
    @invoice_item_6 = create :invoice_item, item: @item_6, invoice: @invoice[5]
    
  end
  describe '::class methods' do
    it 'returns top 5 items' do
      expect(Item.top_5).to contain_exactly(@item_3, @item_1, @item_4, @item_5, @item_6)
    end
  end
  describe 'instance methods' do
    it 'returns items total revenue' do
      item = create :item
      invoice = create :invoice
      create :transaction, result: 0, invoice: invoice
      create :transaction, result: 1, invoice: invoice
      invoice_item = create :invoice_item, unit_price: 10, quantity: 10, item: item, invoice: invoice

      expect(item.total_rev).to eq(100) 
    end
  end
end