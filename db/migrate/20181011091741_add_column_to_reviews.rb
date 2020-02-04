class AddColumnToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :item_id, :integer
    add_column :reviews, :seller_id, :integer
    add_column :reviews, :buyer_id, :integer
  end
end
