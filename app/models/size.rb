# == Schema Information
#
# Table name: sizes
#
#  id         :bigint(8)        not null, primary key
#  size       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Size < ApplicationRecord
  has_many :quantities
  has_many :items, through: :quantities

  validates :size, presence: true
  validates_uniqueness_of :size
end
