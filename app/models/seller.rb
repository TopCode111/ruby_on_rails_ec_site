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

class Seller < User
  acts_as_followable
  has_one :profile, class_name: 'SellerProfile', dependent: :destroy
  accepts_nested_attributes_for :profile, allow_destroy: true, update_only: true
  friendly_id :seller_name, use: :slugged
  has_many :items
  has_many :reviews
  has_one :seller_admin, dependent: :destroy
  scope :listed, -> { includes(:profile).where(seller_profiles:{hide: false}) }

  delegate :name, :description, :photo, :hide, :num_of_items,:instagram_url, :facebook_url, :twitter_url, :line_url, to: :profile
  def seller_name
    self.profile.name
  end

  def should_generate_new_friendly_id?
    new_slug = seller_name.split(' ').join('-').downcase
    slug.blank? || slug != new_slug
  end
end
