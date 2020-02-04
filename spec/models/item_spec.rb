require 'rails_helper'

RSpec.describe Item, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:images) }
    it { should validate_presence_of(:seller_id) }
    it { should validate_presence_of(:category_id) }
    it { should validate_presence_of(:brand_id) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(3).is_at_most(1000).on(:create) }
    it { should validate_numericality_of(:price).is_greater_than(300).on(:create) }
    it { should validate_numericality_of(:shipping_fees).is_greater_than_or_equal_to(0).on(:create) }
  end

  context 'Associations' do
    it { should accept_nested_attributes_for :images }
    it { should accept_nested_attributes_for :quantities }
    it { should have_many(:quantities) }
    it { should have_many(:sizes).through(:quantities) }
    it { should have_many(:images) }
    it { should have_many(:order_items) }
    it { should have_many(:reviews) }
    it { should belong_to(:category) }
    it { should belong_to(:seller) }
    it { should belong_to(:brand) }
    it { should belong_to(:sub_category).optional }
  end
end
