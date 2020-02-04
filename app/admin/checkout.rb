ActiveAdmin.register PurchaseOrder, as: 'Checkout' do
  menu label: 'チェックアウト', priority: 6
  actions :all, except: [:new, :edit, :create, :destroy]

  index do
    column :id
    column :buyer
    column :total_price
    column :purchase_date
    column :status
    actions
  end

  show do
    attributes_table do
      row :buyer
      row :sum_price
      row :sum_shipping_fees
      row :total_price
      row :purchase_date
      row :status
      row :stripe_charge_id
      row t('Shipping address') do |c|
        c.try(:billing_prefecture)+c.try(:billing_address_1)+c.try(:billing_address_2)
      end
      panel t('Order Items') do
        table_for resource.order_items do
          column t('Item Name') do |c|
            if c.item.present?
              link_to c.try(:item_name), admin_item_path(c.item)
            else
              c.try(:item_name)
            end
          end
          column t('Seller Name') do |c|
            if c.seller.present?
              link_to c.try(:seller_name), admin_seller_path(c.seller)
            else
              c.try(:seller_name)
            end
          end
          column :size
          column :unit_price
          column :unit_shipping_fees
          column :total_price
          column :order_status
        end
      end
    end
  end

  controller do
    def scoped_collection
      PurchaseOrder.where.not(buyer_id: nil). where(status: 'Succeeded').order('purchase_date DESC')
    end
  end
end
