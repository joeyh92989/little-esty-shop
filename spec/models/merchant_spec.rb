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
    it 'returns top 5 items' do
      merchant = create :merchant
      merchant_2 = create :merchant, status: "enabled"
      item_1 = create :item, merchant: merchant
      item_2 = create :item, merchant: merchant
      item_3 = create :item, merchant: merchant
      item_4 = create :item, merchant: merchant
      item_5 = create :item, merchant: merchant
      item_6 = create :item, merchant: merchant
      invoice = create_list :invoice, 6
      transactions_1= create_list :transaction, 10, result: 1, invoice: invoice.first
      transactions_2= create_list :transaction, 10, result: 0, invoice: invoice.second
      transactions_6= create_list :transaction, 10, invoice: invoice.third
      transactions_3= create_list :transaction, 10, invoice: invoice.fourth
      transactions_4= create_list :transaction, 10, invoice: invoice.fifth
      transactions_5= create_list :transaction, 10, invoice: invoice[5]
      invoice_item_2 = create :invoice_item, unit_price: 500, quantity: 1, item: item_2, invoice: invoice.first
      invoice_item_3 = create :invoice_item, unit_price: 400, quantity: 2, item: item_3, invoice: invoice.second
      invoice_item_1 = create :invoice_item, unit_price: 300, quantity: 1, item: item_1, invoice: invoice.third
      invoice_item_4 = create :invoice_item, unit_price: 600, quantity: 2, item: item_4, invoice: invoice.fourth
      invoice_item_5 = create :invoice_item, unit_price: 200, quantity: 5, item: item_5, invoice: invoice.fifth
      invoice_item_6 = create :invoice_item, unit_price: 10, quantity: 5, item: item_6, invoice: invoice[5]

      expect(merchant.top_5_items).to contain_exactly(item_3, item_1, item_4, item_5, item_6)
    end
  end

  describe 'class methods' do
    describe '#enabled' do
      it 'returns enabled merchants' do
        merchant = create :merchant
        merchant_2 = create :merchant, status: "enabled"

        expect(Merchant.enabled).to contain_exactly(merchant_2)
      end
    end

    describe '#disabled' do
      it 'returns disabled merchants' do
        merchant = create :merchant
        merchant_2 = create :merchant, status: "enabled"

        expect(Merchant.disabled).to contain_exactly(merchant)
      end
    end

    describe '#top_5_merchants_by_revenue' do
      it 'returns the top 5 merchants by total revenue generated from completed orders' do
        merchant_2 = create :merchant
        merchant_3 = create :merchant
        merchant_4 = create :merchant
        merchant_5 = create :merchant
        merchant_6 = create :merchant
        merchant_7 = create :merchant

        customer = create :customer

        item_2a = create :item, merchant: merchant_2
        item_2b = create :item, merchant: merchant_2

        item_3a = create :item, merchant: merchant_3
        item_3b = create :item, merchant: merchant_3

        item_4a = create :item, merchant: merchant_4
        item_4b = create :item, merchant: merchant_4

        item_5a = create :item, merchant: merchant_5
        item_5b = create :item, merchant: merchant_5

        item_6a = create :item, merchant: merchant_6
        item_6b = create :item, merchant: merchant_6

        item_7 = create :item, merchant: merchant_7

        # 20 dollars in revenue for merchant 2
        invoice_2 = customer.invoices.create!(status: 0)
        invoice_2.transactions.create!(result: 0, credit_card_number: 12345)
        invoice_2.invoice_items.create!(item: item_2a, quantity: 1, unit_price: 10, status: 2)
        invoice_2.invoice_items.create!(item: item_2b, quantity: 10, unit_price: 1, status: 2)


        # 110 dollars in revenue for merchant 3
        invoice_3a = customer.invoices.create!(status: 0)
        invoice_3b = customer.invoices.create!(status: 0)
        invoice_3a.transactions.create!(result: 0, credit_card_number: 12345)
        invoice_3b.transactions.create!(result: 0, credit_card_number: 12345)
        invoice_3a.invoice_items.create!(item: item_3a, quantity: 10, unit_price: 10, status: 2)
        invoice_3b.invoice_items.create!(item: item_3b, quantity: 10, unit_price: 1, status: 2)

        # 2 dollars in revenue for merchant 4
        invoice_4a = customer.invoices.create!(status: 0)
        invoice_4b = customer.invoices.create!(status: 0)
        invoice_4a.transactions.create!(result: 0, credit_card_number: 12345)
        invoice_4b.transactions.create!(result: 0, credit_card_number: 12345)
        invoice_4a.invoice_items.create!(item: item_4a, quantity: 1, unit_price: 1, status: 2)
        invoice_4b.invoice_items.create!(item: item_4b, quantity: 1, unit_price: 1, status: 2)

        # 10 dollars in revenue for merchant 5
        invoice_5a = customer.invoices.create!(status: 0)
        invoice_5b = customer.invoices.create!(status: 0)
        invoice_5a.transactions.create!(result: 0, credit_card_number: 12345)
        invoice_5b.transactions.create!(result: 0, credit_card_number: 12345)
        invoice_5a.invoice_items.create!(item: item_5a, quantity: 5, unit_price: 1, status: 2)
        invoice_5b.invoice_items.create!(item: item_5b, quantity: 1, unit_price: 5, status: 2)

        # 12 dollars in revenue for merchant 6
        invoice_6a = customer.invoices.create!(status: 0)
        invoice_6b = customer.invoices.create!(status: 0)
        invoice_6a.transactions.create!(result: 0, credit_card_number: 12345)
        invoice_6b.transactions.create!(result: 0, credit_card_number: 12345)
        invoice_6a.invoice_items.create!(item: item_6a, quantity: 6, unit_price: 1, status: 2)
        invoice_6b.invoice_items.create!(item: item_6b, quantity: 2, unit_price: 3, status: 2)

        # 60 dollars for merchant 7
        invoice_6b.invoice_items.create!(item: item_7, quantity: 20, unit_price: 3, status: 2)

        actual = Merchant.top_5_merchants_by_revenue.map do |merchant|
          merchant
        end

        expected = [merchant_3, merchant_7, merchant_2, merchant_6, merchant_5]
        expect(actual).to eq(expected)
      end
    end

    describe '#top_merchant_best_day' do
        it 'returns the top 5 merchants by total revenue generated from completed orders' do
          merchant_2 = create :merchant
          merchant_3 = create :merchant
          merchant_4 = create :merchant

          customer = create :customer

          item_2a = create :item, merchant: merchant_2
          item_2b = create :item, merchant: merchant_2

          item_3a = create :item, merchant: merchant_3
          item_3b = create :item, merchant: merchant_3

          item_4a = create :item, merchant: merchant_4
          item_4b = create :item, merchant: merchant_4


          # 20 dollars in revenue for merchant 2
          invoice_2a = customer.invoices.create!(status: 0)
          invoice_2b = customer.invoices.create!(status: 0, created_at: Time.new(2000, 5, 10))
          invoice_2b.transactions.create!(result: 0, credit_card_number: 12345)
          invoice_2b.invoice_items.create!(item: item_2a, quantity: 1, unit_price: 10, status: 2)
          invoice_2b.invoice_items.create!(item: item_2b, quantity: 10, unit_price: 1, status: 2)


          # 110 dollars in revenue for merchant 3
          invoice_3a = customer.invoices.create!(status: 0)
          invoice_3b = customer.invoices.create!(status: 0, created_at: Time.new(2000, 5, 20))
          invoice_3a.transactions.create!(result: 0, credit_card_number: 12345)
          invoice_3b.transactions.create!(result: 0, credit_card_number: 12345)
          invoice_3a.invoice_items.create!(item: item_3a, quantity: 10, unit_price: 10, status: 2)
          invoice_3b.invoice_items.create!(item: item_3b, quantity: 10, unit_price: 1, status: 2)

          # 2 dollars in revenue for merchant 4
          invoice_4a = customer.invoices.create!(status: 0)
          invoice_4b = customer.invoices.create!(status: 0, created_at: Time.new(2000, 5, 30))
          invoice_4a.transactions.create!(result: 0, credit_card_number: 12345)
          invoice_4b.transactions.create!(result: 0, credit_card_number: 12345)
          invoice_4a.invoice_items.create!(item: item_4a, quantity: 1, unit_price: 1, status: 2)
          invoice_4b.invoice_items.create!(item: item_4b, quantity: 1, unit_price: 1, status: 2)

          expect(merchant_2.top_merchant_best_day).to eq(Time.new(2000, 5, 10))
          expect(merchant_3.top_merchant_best_day).to eq(Time.new(2000, 5, 20))
          expect(merchant_4.top_merchant_best_day).to eq(Time.new(2000, 5, 30))
      end
    end
  end
end
