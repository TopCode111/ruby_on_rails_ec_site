class AddColumnToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :brand_id, :integer
    add_column :items, :sub_category_id, :integer
    add_column :items, :seller_id, :integer
    add_column :items, :size_id, :integer
  end
end
