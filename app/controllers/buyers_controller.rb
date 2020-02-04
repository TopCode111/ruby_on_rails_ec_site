class BuyersController < ApplicationController
  before_action :authenticate_user!
  def show
    sidebar_data
    @buyer = current_user
  end

  def shipping_address
    @buyer = current_user
    @billing_address = @buyer.build_billing_address unless current_user.billing_address.present?
  end

  def update
    params[:buyer][:billing_address_attributes][:zip_code] = params[:zip_code_1] + '-' + params[:zip_code_2] if params[:zip_code_1].present? && params[:zip_code_2].present?
    if current_user.update_attributes(buyer_params)
      return redirect_to cart_path if request.referer.present? && request.referer.split('/').include?('cart')
      redirect_to address_payments_path
    end
  end

  def address_payments
    sidebar_data
    @address = current_user.billing_address
    @payment = current_user.payment_account
  end

  private

  def buyer_params
    params.require(:buyer).permit(billing_address_attributes: [:bulling_address_id,
                                                               :address_1,
                                                               :address_2,
                                                               :prefecture,
                                                               :zip_code,
                                                               :buyer_id],
                                  payment_account_attributes: [:payment_account_id,
                                                               :card_no,
                                                               :customer_token,
                                                               :buyer_id,
                                                               :card_type])
  end
end
