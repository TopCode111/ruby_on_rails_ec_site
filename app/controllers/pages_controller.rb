class PagesController < ApplicationController
  def index
    sidebar_data
    @newest_items = @items.order(created_at: :desc).limit(10)
    @popular_items = @items.order(purchase_count: :desc).limit(10)
    @famous_sellers = @sellers.joins(:items).order('items.purchase_count DESC')
  end

  def privacy
    sidebar_data
  end

  def terms_condition
    sidebar_data
  end

  def design_guide;end

  def categories;end

  def item;end

end
