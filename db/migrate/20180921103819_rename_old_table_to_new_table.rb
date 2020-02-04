class RenameOldTableToNewTable < ActiveRecord::Migration[5.2]
  def change
  	rename_table :item_sizes, :items_sizes
  end
end
