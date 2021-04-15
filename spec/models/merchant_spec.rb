require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :dashboards }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }


  end
end
