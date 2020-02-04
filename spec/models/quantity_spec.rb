require 'rails_helper'

RSpec.describe Quantity, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:size_id) }
  end

  context 'Associations' do
    it { should belong_to(:item) }
    it { should belong_to(:size) }
  end
end
