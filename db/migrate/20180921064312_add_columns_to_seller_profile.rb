class AddColumnsToSellerProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :seller_profiles, :instagram_url, :string
    add_column :seller_profiles, :twitter_url, :string
    add_column :seller_profiles, :line_url, :string
    add_column :seller_profiles, :facebook_url, :string
  end
end
