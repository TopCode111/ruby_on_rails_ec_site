# == Schema Information
#
# Table name: buyer_profiles
#
#  id         :bigint(8)        not null, primary key
#  first_name :string
#  last_name  :string
#  buyer_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BuyerProfile < ApplicationRecord
  belongs_to :buyer
  validates :first_name, :last_name, presence: true
end
