# == Schema Information
#
# Table name: purchase_orders
#
#  id                 :bigint(8)        not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  item_id            :integer
#  seller_id          :integer
#  buyer_id           :integer
#  price              :integer
#  shipping_fees      :integer
#  size_id            :integer
#  total_price        :integer
#  status             :string           default("Pending")
#  stripe_charge_id   :string
#  payment_account_id :integer
#  purchase_date      :datetime
#  quantity_id        :integer
#  reviewed           :boolean          default(FALSE)
#  item_name          :string
#  seller_name        :string
#  size_type          :string
#  billing_address_1  :string
#  billing_address_2  :string
#  billing_prefecture :string
#  billing_zip_code   :string
#  qty                :integer
#

class PurchaseOrder < ApplicationRecord
  belongs_to :buyer, optional: true
  # belongs_to :quantity
  has_many :order_items
  belongs_to :payment_account, optional: true

  def succeeded?
    return true if status == 'Succeeded'
    false
  end

  def pending?
    return true if status == 'Pending'
    false
  end

  def total_sum_price
    order_items.collect {|o| o.valid? ? o.unit_price: 0}.sum
  end

  def total_shipping_fees
    order_items.collect {|o| o.valid? ? o.unit_shipping_fees: 0}.sum
  end

  def final_price
    order_items.collect {|o| o.valid? ? (o.unit_shipping_fees + o.unit_price) : 0}.sum
  end
end
