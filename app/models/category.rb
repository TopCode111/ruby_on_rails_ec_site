# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
	has_many :items
	has_many :sub_categories, dependent: :destroy
	validates :title, presence: true
	validates_uniqueness_of :title
	accepts_nested_attributes_for :sub_categories, :allow_destroy => true, update_only: true
end
