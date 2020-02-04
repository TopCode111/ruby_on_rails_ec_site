# == Schema Information
#
# Table name: items
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  price           :integer          default(0)
#  description     :text
#  shipping_fees   :integer          default(0)
#  category_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  brand_id        :integer
#  sub_category_id :integer
#  seller_id       :integer
#  publish         :boolean          default(TRUE)
#  deleted_at      :datetime
#  purchase_count  :integer          default(0)
#  slug            :string
#

class Item < ApplicationRecord
  acts_as_paranoid
  acts_as_commentable
  extend FriendlyId
  friendly_id :name, use: :slugged
  include PgSearch
  pg_search_scope :search_item, :against => [:name],
                                associated_against: { brand: :name,}, using: { tsearch: { prefix: true } }
  belongs_to :category
  belongs_to :seller
  belongs_to :brand
  belongs_to :sub_category, optional: true
  has_many :quantities
  has_many :sizes, through: :quantities
  has_many :images
  has_many :order_items
  # has_many :buyers, through: :purchase_orders
  has_many :reviews

  validates :seller_id, :category_id, :brand_id, :name, :price, presence: true
  validates_presence_of :images
  validates :description, length: {minimum: 3, maximum: 1000}, presence: true
  validates_numericality_of :price, greater_than: 300
  validates_numericality_of :shipping_fees, greater_than_or_equal_to: 0
  accepts_nested_attributes_for :images, :quantities, :allow_destroy => true, update_only: true
  after_create :update_seller_item_count
  scope :published, -> { where(publish: true) }
  scope :authorized_seller, -> { joins(seller: :profile).where(seller_profiles: {hide: false}) }

  def update_seller_item_count
    num_of_item = seller.items.count
    seller.profile.update(num_of_items: num_of_item)
  end

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  def remaining_size
    quantities.where.not(remaining: 0)
  end

  def first_image
    images.first.image
  end

  def total_price
    price + shipping_fees
  end
end
