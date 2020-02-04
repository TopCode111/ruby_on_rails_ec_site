class ApplicationController < ActionController::Base
  before_action :set_locale
  include SidebarData

  protect_from_forgery
  helper_method :current_purchase_order

  rescue_from ActiveRecord::RecordNotFound do
    render 'errors/not_found', status: :not_found
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def current_purchase_order
    if !session[:purchase_order_id].nil?
      PurchaseOrder.find(session[:purchase_order_id])
    else
      purchase_order = PurchaseOrder.create
      session[:purchase_order_id] = purchase_order.id
      return purchase_order
    end
  end

  private

  def after_sign_out_path_for(resource)
    if resource == :admin_user
       new_admin_user_session_path
    elsif resource == :seller_admin
      new_seller_admin_session_path
    else
      root_path
    end
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_dashboard_path
    elsif resource.is_a?(SellerAdmin)
      seller_admins_seller_path(resource.seller)
    elsif resource.seller?
      seller_after_sign_in
    elsif params[:controller] == 'registrations' && (request.referer.present? && request.referer.split('/').include?('cart'))
      cart_path
    elsif params[:controller] == 'registrations'
      signup_success_path
    elsif resource.is_a?(Buyer) && (request.referer.present? && request.referer.split('/').include?('cart'))
      cart_path
    elsif resource.is_a?(Buyer)
      root_path
    end
  end

  def seller_after_sign_in
    sign_out(current_user)
    flash.delete(:notice)
    flash[:alert] = t('You are unauthorized to login')
    root_path
  end
end
