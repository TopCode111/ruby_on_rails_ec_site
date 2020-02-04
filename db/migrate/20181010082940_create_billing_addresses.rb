class CreateBillingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :billing_addresses do |t|
    	t.string :address_1
    	t.string :address_2
    	t.string :city
    	t.string :prefecture
    	t.string :zip_code
      t.integer :buyer_id, index: true
      t.timestamps
    end
  end
end
