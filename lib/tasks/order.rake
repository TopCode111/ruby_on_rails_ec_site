namespace :order do
  task :update_info => :environment do
    PurchaseOrder.all.each do |order|
      order.item.present? ? order.update(item_name: order.item.name) : order.update(item_name: "Deleted item")
      order.seller.present? ? order.update(seller_name: order.seller.name) : order.update(seller_name: "Deleted seller")
      order.update(size_type: order.size.size) if order.size.present?
      order.update(seller_name: order.seller.name) if order.seller.present?
      if order.buyer.present? && order.buyer.billing_address.present?
        address = order.buyer.billing_address
        order.update_attributes(billing_address_1: address.address_1,
                                billing_address_2: address.address_2,
                                billing_prefecture: address.prefecture,
                                billing_zip_code: address.zip_code)
      end
    end
  end
end
