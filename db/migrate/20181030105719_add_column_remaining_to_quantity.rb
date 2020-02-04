class AddColumnRemainingToQuantity < ActiveRecord::Migration[5.2]
  def change
    add_column :quantities, :remaining, :integer
    add_column :quantities, :purchased, :integer, default: 0
  end
end
