class CreateBuyerProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :buyer_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.integer :buyer_id, index: true

      t.timestamps
    end
  end
end
