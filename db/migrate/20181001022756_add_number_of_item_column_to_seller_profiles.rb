class AddNumberOfItemColumnToSellerProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :seller_profiles, :num_of_items, :integer, default: 0
  end
end
