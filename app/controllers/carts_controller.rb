class CartsController < ApplicationController
  include ValidBuyer
  before_action :initialize_user, only: [:show, :cart_user_register, :cart_new_password]
  before_action :set_order, only: [:cart_user_register, :cart_new_password]
  before_action :check_valid_buyer, only: [:cart_user_register, :cart_new_password]

  def show
    sidebar_data
    @purchase_order = current_purchase_order
    if current_user.present?
      @order_items = @purchase_order.order_items.order(created_at: :desc)
    else
      @order_items = @purchase_order.order_items.where(buyer_id: nil).order(created_at: :desc)
    end
  end

  def cart_user_register
    sidebar_data
  end

  def cart_new_password
    sidebar_data
  end

  def destroy
    order_item = OrderItem.find(params[:id])
    order_item.destroy
    redirect_to cart_path
  end

  private

  def initialize_user
    @user = User.new
  end

  def set_order
    @order = current_purchase_order
  end
end