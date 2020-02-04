class CreateSellerProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :seller_profiles do |t|
      t.integer :seller_id
      t.string :name
      t.string :photo
      t.text :description

      t.timestamps
    end
  end
end
