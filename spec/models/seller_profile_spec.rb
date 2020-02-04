 require 'rails_helper'

RSpec.describe SellerProfile, type: :model do
  context "Validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it { should validate_presence_of(:photo)}
  end

  context "Associations" do
    it {should belong_to(:seller)}
  end
end
