FactoryBot.define do
  factory :order_item do
    item_id { 1 }
    purchase_order_id { 1 }
    buyer_id { 1 }
    seller_id { 1 }
    quantity_id { 1 }
    unit_price {200}
    unit_shipping_fees {0}
    total_price {200}
    size {'L'}
    seller_name {'rasna'}
    item_name {'fashion love'}
    order_status {'InProgress'}
    reviewed {false}
  end
end
