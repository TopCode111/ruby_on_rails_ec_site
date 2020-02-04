# == Schema Information
#
# Table name: quantities
#
#  id         :bigint(8)        not null, primary key
#  item_id    :bigint(8)
#  size_id    :bigint(8)
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  remaining  :integer
#  purchased  :integer          default(0)
#

class Quantity < ApplicationRecord
  belongs_to :size
  belongs_to :item
  before_save :save_remaining
  validates :quantity, :size_id, presence: true
  after_save :check_quantity

  def check_quantity
    if remaining == 0
      OrderItem.where(item_id: item.id, quantity_id: self.id, order_status: 'InProgress').destroy_all
    end
  end

  def save_remaining
    self.remaining = quantity - purchased
  end
end
