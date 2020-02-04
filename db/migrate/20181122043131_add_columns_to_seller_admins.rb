class AddColumnsToSellerAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :seller_admins, :seller_id, :integer, index: true
  end
end
