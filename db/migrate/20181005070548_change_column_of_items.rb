class ChangeColumnOfItems < ActiveRecord::Migration[5.2]
  def change
  	change_column :items, :price, :float, :default => 0
  	change_column :items, :shipping_fees, :float, :default => 0
  end
end
