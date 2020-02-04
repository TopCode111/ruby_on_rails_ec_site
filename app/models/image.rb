# == Schema Information
#
# Table name: images
#
#  id         :bigint(8)        not null, primary key
#  image      :string
#  item_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Image < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :item
  validates :image, presence: true
end
