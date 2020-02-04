# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  type                   :string
#  slug                   :string
#

class Buyer < User
  acts_as_follower
  has_one :profile, class_name: 'BuyerProfile', dependent: :destroy
  has_one :billing_address
  has_one :payment_account
  has_many :order_items
  has_many :purchase_orders
  # has_many :items, through: :order_items
  has_many :reviews

  accepts_nested_attributes_for :profile, :billing_address, :payment_account, allow_destroy: true, update_only: true
  delegate :first_name, :last_name, to: :profile
  delegate :address_1, :address_2, :zip_code, :city, :prefecture, to: :billing_address
  delegate :stripe_customer_id, to: :payment_account
  before_create :build_profile

  def full_name
    last_name + first_name if last_name.present? && first_name.present?
  end
end
