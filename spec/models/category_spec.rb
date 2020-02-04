require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:title) }
    it { should validate_uniqueness_of(:title) }
  end

  context 'Associations' do
    it { should accept_nested_attributes_for :sub_categories }
    it { should have_many(:items) }
    it { should have_many(:sub_categories) }
  end
end
