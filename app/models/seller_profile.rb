# == Schema Information
#
# Table name: seller_profiles
#
#  id            :bigint(8)        not null, primary key
#  seller_id     :integer
#  name          :string
#  photo         :string
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instagram_url :string
#  twitter_url   :string
#  line_url      :string
#  facebook_url  :string
#  hide          :boolean          default(FALSE)
#  num_of_items  :integer          default(0)
#

class SellerProfile < ApplicationRecord
  validates :name, :description, :photo , presence: true
  belongs_to :seller
  mount_uploader :photo, AvatarUploader
end
