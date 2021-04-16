require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }

  end
  describe 'validations' do
    it { should validate_presence_of(:status) }

  end
  before(:each) do
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
end