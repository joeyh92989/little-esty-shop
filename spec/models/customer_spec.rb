require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
  end
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end
  
  before(:each) do
 
    @merchant_1 = create :merchant
    @item_1 = create_list :item, 10, merchant: @merchant_1
    @invoice_item_1 = create_list :invoice_item, 10
    binding.pry
  end
  describe '::class methods' do
      it 'returns top 5 customers' do
        binding.pry
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
  end
end