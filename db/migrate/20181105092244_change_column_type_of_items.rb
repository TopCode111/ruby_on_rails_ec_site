class ChangeColumnTypeOfItems < ActiveRecord::Migration[5.2]
  def change
  	change_column :items, :price, :integer
  	change_column :items, :shipping_fees, :integer
  end
end
