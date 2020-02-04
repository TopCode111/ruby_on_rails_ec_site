# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  type                   :string
#  slug                   :string
#


require 'rails_helper'

RSpec.describe Seller, type: :model do
  describe "Associations" do
    it {should have_many(:items)}
    it {should have_one(:profile)}
    it {should have_many(:reviews)}
    it {should have_one(:seller_admin)}
    it{should accept_nested_attributes_for(:profile)}
  end
end
