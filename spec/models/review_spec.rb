require 'rails_helper'

RSpec.describe Review, type: :model do
  context "Association" do
    it {should belong_to(:item)}
    it {should belong_to(:seller)}
    it {should belong_to(:buyer)}
  end
end
