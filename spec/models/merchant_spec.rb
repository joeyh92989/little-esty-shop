require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant = create :merchant
    @item_1 = create :item, merchant: @merchant
    @item_2 = create :item, merchant: @merchant
    @item_3 = create :item, merchant: @merchant
    @item_4 = create :item, merchant: @merchant
    @item_5 = create :item, merchant: @merchant
    @item_6 = create :item, merchant: @merchant
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
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
  end
  describe 'instance methods' do
    # redo the test to include specific arguments 
    it 'returns top 5 items' do
      
      expect(@merchant.top_5_items).to contain_exactly(@item_3, @item_1, @item_4, @item_5, @item_6)
    end

  end
end
