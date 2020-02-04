# == Schema Information
#
# Table name: brands
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Brand < ApplicationRecord
  has_many :items
  validates :name, presence: true
  validates_uniqueness_of :name
end
