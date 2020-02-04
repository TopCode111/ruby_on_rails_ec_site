class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.text :description
      t.float :shipping_fees
      t.integer :category_id

      t.timestamps
    end
  end
end
