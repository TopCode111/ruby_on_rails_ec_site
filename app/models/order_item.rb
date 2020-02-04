class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :purchase_order
  belongs_to :buyer, optional: true
  belongs_to :seller
  belongs_to :quantity

  before_save :finalize

  def purchased?
    return true if order_status == 'Purchased'
    false
  end

  def unit_price
    if persisted?
      self[:unit_price]
    else
      item.price
    end
  end

  def unit_shipping_fees
    if persisted?
      self[:unit_shipping_fees]
    else
      item.shipping_fees
    end
  end

  def total_price
    unit_price + unit_shipping_fees
  end

  private

  def finalize
    self[:unit_price] = unit_price
    self[:unit_shipping_fees] = unit_shipping_fees
    self[:total_price] = total_price
    self[:size] = quantity.size.size
    self[:item_name] = item.name
    self[:seller_name] = seller.name
  end
end
