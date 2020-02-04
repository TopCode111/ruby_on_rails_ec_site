require 'rails_helper'

RSpec.describe BuyerProfile, type: :model do
  context "Validations" do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end

  context "Associations" do
    it {should belong_to(:buyer)}
  end
end
