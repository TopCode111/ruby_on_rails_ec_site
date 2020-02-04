require 'rails_helper'

RSpec.describe PaymentAccount, type: :model do
  context "Validations" do
    it {should belong_to(:buyer)}
  end
end
