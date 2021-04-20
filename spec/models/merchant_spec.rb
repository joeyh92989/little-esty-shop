require 'rails_helper'

RSpec.describe Merchant, type: :model do
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
    before :each do
      @merchant_1 = create(:merchant)
      @item = create_list(:item, 6, merchant: @merchant_1)

      @invoice = create_list(:invoice, 6)
      @customer_1 = @invoice[0].customer
      @customer_2 = @invoice[1].customer
      @customer_3 = @invoice[2].customer
      @customer_4 = @invoice[3].customer
      @customer_5 = @invoice[4].customer
      @customer_6 = @invoice[5].customer

      @invoice_item_1 = create(:invoice_item, item: @item[0], invoice: @invoice[0])
      @invoice_item_2 = create(:invoice_item, item: @item[1], invoice: @invoice[1])
      @invoice_item_3 = create(:invoice_item, item: @item[2], invoice: @invoice[2])
      @invoice_item_4 = create(:invoice_item, item: @item[3], invoice: @invoice[3])
      @invoice_item_5 = create(:invoice_item, item: @item[4], invoice: @invoice[4])
      @invoice_item_6 = create(:invoice_item, item: @item[5], invoice: @invoice[5])

      @transaction_1 = create_list(:transaction, 20, invoice: @invoice[0])
      @transaction_2 = create_list(:transaction, 15, invoice: @invoice[1])
      @transaction_3 = create_list(:transaction, 10, invoice: @invoice[2])
      @transaction_4 = create_list(:transaction, 7, invoice: @invoice[3])
      @transaction_5 = create_list(:transaction, 5, invoice: @invoice[4])
      @transaction_6 = create_list(:transaction, 3, invoice: @invoice[5])
    end

    describe '#top_5_by_transactions'do
      it "shows names of the top 5 customers by successful transactions" do
        actual = @merchant_1.top_5_by_transactions.map do |customer|
          customer
        end

        expected = [@customer_1, @customer_2, @customer_3, @customer_4, @customer_5]
        require 'pry'; binding.pry

        expect(actual).to eq(expected)
      end
    end
  end
end
