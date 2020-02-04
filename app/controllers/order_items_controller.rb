class OrderItemsController < ApplicationController

  def create
    sidebar_data
    @purchase_order = current_purchase_order
    @order_item = @purchase_order.order_items.new(order_item_params)
    respond_to do |format|
      if @order_item.save
        format.html {render nothing}
        format.js {render layout: false}
      else
        redirect_to :back
      end
    end
  end


  private
  def order_item_params
    params.require(:order_item).permit(:item_id, :buyer_id, :quantity_id, :unit_price, :unit_shipping_fees, :total_price, :size, :seller_id )
  end
end
