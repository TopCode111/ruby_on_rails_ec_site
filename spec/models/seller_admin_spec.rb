require 'rails_helper'

RSpec.describe SellerAdmin, type: :model do
  context "Associations" do
    it {should belong_to(:seller)}
  end
end
