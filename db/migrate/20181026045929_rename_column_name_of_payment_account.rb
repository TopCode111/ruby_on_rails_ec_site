class RenameColumnNameOfPaymentAccount < ActiveRecord::Migration[5.2]
  def change
  	rename_column :payment_accounts, :customer_id, :stripe_customer_id
  end
end
