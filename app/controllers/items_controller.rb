class ItemsController < ApplicationController
  def index
    sidebar_data
    @items = @items.includes(:sub_category, :category, :brand).order(created_at: :desc)
    if params[:category_name].present? && params[:sub_category_name].present?
      @items = @items.where(categories: {title: params[:category_name]}).where(sub_categories: {name: params[:sub_category_name]})
    elsif params[:category_name].present?
      @items = @items.where(categories: {title: params[:category_name]})
    elsif params[:brand_name].present?
      @items = @items.where(brands: {name: params[:brand_name]})
    end
    @items = @items.page(params[:page]).per(40)
  end

  def search
    sidebar_data
    @items = @items.search_item(params[:keyword]) if params[:keyword].present?
    if params[:search].present?
      items = @items
      items = items.search_item(params[:search][:search_keyword]) if params[:search][:search_keyword].present?
      items = items.search_item(params[:search][:search_brand]) if params[:search][:search_brand].present?
      item_ids = items.pluck(:id)
      @items = @items.includes(:category, :sub_category, :sizes).where(id: item_ids)
      @items = @items.where(categories: {id: params[:search][:category]}) if params[:search][:category].present?
      @items = @items.where(sub_categories: {id: params[:search][:sub_category]}) if params[:search][:sub_category].present?
      @items = @items.where(sizes:{id: params[:search][:sizes]}) if params[:search][:sizes].present?
      @items = get_price_range(params[:search][:low_price], params[:search][:high_price], @items)
      @items = @items.where(shipping_fees:0.0) if params[:search][:free_shipping].present? && params[:search][:free_shipping] == 'true'
    end
    @items = @items.order(created_at: :desc).page(params[:page]).per(40)
  end

  def show
    sidebar_data
    @item = @items.friendly.find(params[:id])
    @related_items = @items.includes(:sizes)
                           .where(sub_category_id: @item.sub_category_id)
                           .where.not(id: @item.id)
                           .order(created_at: :desc)
                           .limit(10)
    @reviews = @item.reviews.order(created_at: :desc).limit(3)
    @all_comments = @item.root_comments.order(created_at: :desc).page(params[:page]).per(10)
    @cart_related_items = @related_items.limit(3)
    respond_to do |format|
      format.html {render :show}
      format.js {render layout: false}
    end
  end

  def sub_category_list
    category = Category.find_by(id: params[:category_id])
    @sub_categories = category.sub_categories if category.present?
    respond_to do |format|
      format.html {render layout: false}
      format.js {render layout: false}
    end
  end

  private
  def get_price_range(low, high, items)
    return items unless low.present? || high.present?
    low_price = low.present? ? low : '0'
    high_price = high.present? ? high : '100000'
    items.where(price: low_price..high_price)
  end
end
