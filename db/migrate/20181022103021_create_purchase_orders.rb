class CreatePurchaseOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :purchase_orders do |t|
      t.integer :buyer_id, index: true
      t.integer :sum_price
      t.integer :sum_shipping_fees
      t.integer :total_price
      t.string :status, default: 'Pending'
      t.string :stripe_charge_id
      t.integer :payment_account_id, index: true
      t.datetime :purchase_date
      t.string :billing_address_1
      t.string :billing_address_2
      t.string :billing_prefecture
      t.string :billing_zip_code
      t.timestamps
    end
  end
end
