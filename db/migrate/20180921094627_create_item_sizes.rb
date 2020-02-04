class CreateItemSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :item_sizes, id: false do |t|
    	t.belongs_to :item, index: true
      t.belongs_to :size, index: true
    end
  end
end
