# == Schema Information
#
# Table name: sub_categories
#
#  id          :bigint(8)        not null, primary key
#  category_id :integer
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :items
  validates :name, presence: true
end
