require 'rails_helper'

RSpec.describe BillingAddress, type: :model do
  context "Association" do
    it {should belong_to(:buyer)}
  end
end
