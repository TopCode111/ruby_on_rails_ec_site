class AddColumnPurchaseCountToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :purchase_count, :integer, default: 0
  end
end
