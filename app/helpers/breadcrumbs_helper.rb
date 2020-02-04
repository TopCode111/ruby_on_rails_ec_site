module BreadcrumbsHelper
  def display_breadcrumbs
    if params[:category_name].present? && params[:sub_category_name].present?
      breadcrumb :sub_category, params[:category_name], params[:sub_category_name]
    elsif params[:category_name].present?
      breadcrumb :category, params[:category_name]
    elsif params[:brand_name].present?
      breadcrumb :brand,  params[:brand_name]
    elsif params[:controller] == "buyers"
      breadcrumb current_user
      breadcrumb :shipping_and_payment_info if params[:action] == "address_payments"
    elsif params[:controller] == "purchase_orders" && params[:action] == "checkout"
      breadcrumb :checkout, params[:id]
    end
  end
end
