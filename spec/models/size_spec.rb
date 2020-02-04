require 'rails_helper'

RSpec.describe Size, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:size) }
    it { should validate_uniqueness_of(:size) }
   end

  context 'Associations' do
    it { should have_many(:quantities) }
    it { should have_many(:items).through(:quantities) }
  end
end
