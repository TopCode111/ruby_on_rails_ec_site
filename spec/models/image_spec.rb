require 'rails_helper'

RSpec.describe Image, type: :model do
  context "Validations" do
    it{should validate_presence_of(:image)}
  end

  context "Associations" do
    it{should belong_to(:item)}
  end
end
