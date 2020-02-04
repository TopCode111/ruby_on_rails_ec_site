class PurchaseOrderDecorator < Draper::Decorator
  delegate_all

  def order_item_count(user)
    if user.present?
      order_items.count if order_items.count > 0
    else
      order_items.where(buyer_id: nil).count  if order_items.where(buyer_id: nil).count > 0
    end
  end
end
