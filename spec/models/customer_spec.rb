require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end
  
  before(:each) do
    @customer = create_list(:customer, 6)
    @invoice = @customer.each{|customer| create :invoice, customer: customer}
    @transaction_1 = create_list :transaction, 10, result: 0, invoice: @customer[0].invoices.first
    @transaction_2 = create_list :transaction, 9, result: 0, invoice: @customer[1].invoices.first
    @transaction_3 = create_list :transaction, 8, result: 0, invoice: @customer[2].invoices.first
    @transaction_4 = create_list :transaction, 7, result: 0, invoice: @customer[3].invoices.first
    @transaction_5 = create_list :transaction, 6, result: 0, invoice: @customer[4].invoices.first
    @transaction_6 = create_list :transaction, 10, result: 1, invoice: @customer[5].invoices.first
  end
  describe '::class methods' do
      it 'returns top 5 customers' do
        expected = [@customer[0],@customer[1],@customer[2],@customer[3],@customer[4]]
        expect(Customer.top_5).to eq(expected)
        # (@customer[0],@customer[1],@customer[2],@customer[3],@customer[4])
      end
  end
  describe '#instance methods' do
    it 'returns the # of succesful transactions' do
      expect(@customer[0].number_of_succesful_transactions).to eq(10)
    end
  end
end