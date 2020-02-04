class PurchaseOrdersController < ApplicationController
  include ValidBuyer
  before_action :authenticate_user!, only: [:confirm_checkout, :index, :checkout_success]
  before_action :set_order, only:[:checkout_success, :confirm_checkout]
  before_action :check_valid_buyer, only: [:confirm_checkout, :checkout_success]

  def index
    sidebar_data
    @purchase_orders = current_user.purchase_orders.where(status: "Succeeded").order('purchase_date DESC').page(params[:page]).per(20)
  end

  def confirm_checkout
    return redirect_to cart_path unless current_user.billing_address.present? && current_user.payment_account.present?
    if @order.order_items.present? && !@order.succeeded?
      begin
        stripe_handler = StripeHandler.new
        payment_interface = PaymentInterface.new(current_user, stripe_handler)
        stripe_charge = payment_interface.create_charge(current_user.stripe_customer_id,  @order.final_price)
        if stripe_charge.present?
          @order.buyer = current_user
          @order.payment_account = current_user.payment_account
          @order.stripe_charge_id = stripe_charge.id
          @order.status = 'Succeeded'
          @order.purchase_date = Time.current
          @order.save
          session.delete(:purchase_order_id)
          update_order_item_status(@order)
          update_item_purchase_count(@order)
          update_item_quantity(@order)
          update_purchase_order_info(@order)
          notify_email(@order)
          redirect_to checkout_success_path(@order)
        end
      rescue => e
        flash[:alert] = e.message
      end
    else
      flash[:notice] = t("You have already ordered this item")
      redirect_to cart_path
    end
  end

  def checkout_success
    sidebar_data
    @order_items = @order.order_items.where(order_status: 'Purchased')
    @related_items = @items.where(sub_category_id: @order_items.map {|o| o.item.sub_category_id})
                           .where.not(id: @order_items.map {|o| o.item_id})
                           .order(created_at: :desc)
                           .limit(5)
  end

  private
  def purchase_order_params
    params.require(:purchase_order).permit(:item_id, :buyer_id, :status)
  end

  def update_order_item_status(order)
    order.order_items.update_all(buyer_id: current_user.id, order_status: 'Purchased')
  end

  def set_order
    @order = PurchaseOrder.find(params[:id])
  end

  def update_item_quantity(order)
    if  order.succeeded?
      order.order_items.each do |o|
        o.quantity.reload
        o.quantity.update(purchased: o.quantity.purchased + 1)
      end
    end
  end

  def update_item_purchase_count(order)
    if  order.present? &&  order.succeeded?
      order.order_items.map {|o| o.item.update(purchase_count: o.item.purchase_count + 1) if o.order_status=="Purchased"}
    end
  end

  def notify_email(order)
    UserNotifierMailer.delay.send_buyer_purchase_info(order)
    UserNotifierMailer.delay.send_admin_purchase_info(order)
  end

  def update_purchase_order_info(order)
    order.update(sum_price: order.total_sum_price,
                                  sum_shipping_fees:  order.total_shipping_fees,
                                  total_price:  order.final_price) if  order.present?
    if current_user.present? && current_user.billing_address.present?
      address = current_user.billing_address
      order.update_attributes(billing_address_1: address.address_1,
                                               billing_address_2: address.address_2,
                                               billing_prefecture: address.prefecture,
                                               billing_zip_code: address.zip_code)
    end
  end
end
