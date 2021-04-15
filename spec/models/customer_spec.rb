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
    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Haas")
    @customer_2 = Customer.create!(first_name: "Austin", last_name: "Andrade")
    @customer_3 = Customer.create!(first_name: "Joe", last_name: "Ray")
    @customer_4 = Customer.create!(first_name: "Carlyle", last_name: "Douglas")
    @customer_5 = Customer.create!(first_name: "Kon", last_name: "Ham")
    @customer_6 = Customer.create!(first_name: "Andrew", last_name: "Smith")
    @customer_7 = Customer.create!(first_name: "Olivia", last_name: "Charles")
    @customer_8 = Customer.create!(first_name: "KK", last_name: "Kudzelich")
    @customer_9 = Customer.create!(first_name: "Kathy", last_name: "Bui")

    @merchant_1 = create :merchant
    @item_1 = create_list :item, 10, merchant: @merchant_1
    binding.pry
  end
  describe '::class methods' do
      it 'returns top 5 customers' do
        binding.pry
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
  end
end