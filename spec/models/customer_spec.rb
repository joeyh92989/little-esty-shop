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
    @customer_1 = Customer.create!(first_name: "Austin", last_name: "Andrade")
    @customer_1 = Customer.create!(first_name: "Joe", last_name: "Ray")
    @customer_1 = Customer.create!(first_name: "Carlyle", last_name: "Douglas")
    @customer_1 = Customer.create!(first_name: "Kon", last_name: "Ham")
    @customer_1
    @customer_1
    @customer_1
    @customer_1
  end
  describe 'class methods' do
      it 'returns top 5 customers' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
  end
end