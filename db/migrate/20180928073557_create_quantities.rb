class CreateQuantities < ActiveRecord::Migration[5.2]
  def change
    create_table :quantities do |t|
    	t.belongs_to :item, index: true
      t.belongs_to :size, index: true
      t.integer :quantity

      t.timestamps
    end
  end
end
