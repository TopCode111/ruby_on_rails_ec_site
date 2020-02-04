class CreatePaymentAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_accounts do |t|
      t.integer :buyer_id, index:true
      t.integer :card_no
      t.string :card_type
      t.string :customer_id
      t.integer :exp_month
      t.integer :exp_year
      t.timestamps
    end
  end
end
