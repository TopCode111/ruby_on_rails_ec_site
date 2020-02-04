class AddHideColumnToSellerProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :seller_profiles, :hide, :boolean, default: false
  end
end
