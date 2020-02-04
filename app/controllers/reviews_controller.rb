class ReviewsController < ApplicationController
  include ValidBuyer
  before_action :authenticate_user!
  before_action :set_order, only: :new
  before_action :check_valid_buyer , only: :new
  def new
    sidebar_data
    @review = Review.new
    @item = @items.friendly.find(params[:id])
  end

  def create
    @order = OrderItem.find(params[:review][:order_id])
    return redirect_to item_review_path(@order, @order.item_id) if @order.reviewed
    @review = current_user.reviews.new(review_params)
    if @review.save
      @order.update(reviewed: true)
      flash[:notice] = t("Item successfully reviewed")
      redirect_to purchase_history_path
    else
      flash[:error] = t("You cannot review this item")
      redirect_to root_path
    end
  end

  private
  def review_params
    params.require(:review).permit(:description, :rating, :item_id, :seller_id, :buyer_id)
  end

  def set_order
    @order = OrderItem.find(params[:order_id])
  end
end
