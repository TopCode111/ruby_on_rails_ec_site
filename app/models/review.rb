# == Schema Information
#
# Table name: reviews
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  rating      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  item_id     :integer
#  seller_id   :integer
#  buyer_id    :integer
#

class Review < ApplicationRecord
  belongs_to :item
  belongs_to :seller
  belongs_to :buyer

  def blank_star
    5 - self.rating.to_i
  end
end
