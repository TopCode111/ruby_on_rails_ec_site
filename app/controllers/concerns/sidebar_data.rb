module SidebarData
  extend ActiveSupport::Concern

  def sidebar_data
    @categories = Category.all
    @brands = Brand.all
    @sellers = Seller.listed
    @items = Item.published.authorized_seller
  end
end
