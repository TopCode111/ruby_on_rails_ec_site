require 'rails_helper'

RSpec.describe SubCategory, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:name) }
	end

	context 'Valiadtions' do
    it { should have_many(:items) }
    it { should belong_to(:category) }
  end
end
