require 'rails_helper'

describe Dashboard, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
  end
end
