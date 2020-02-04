require 'rails_helper'

RSpec.describe PurchaseOrder, type: :model do
  context "Associations" do
    it {should belong_to(:buyer).optional}
    it {should belong_to(:payment_account).optional}
  end
end
