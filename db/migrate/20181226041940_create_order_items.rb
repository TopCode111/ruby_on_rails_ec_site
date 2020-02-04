class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :item_id, index: true
      t.integer :purchase_order_id, index: true
      t.integer :buyer_id, index: true
      t.integer :quantity_id, index: true
      t.integer :unit_price
      t.integer :unit_shipping_fees
      t.integer :total_price
      t.string :size
      t.integer :seller_id, index: true
      t.string :seller_name
      t.string :item_name
      t.string :order_status, default: 'InProgress'
      t.boolean :reviewed, default: false

      t.timestamps
    end
  end
end
