crumb :root do
  link t("Pick Top"), root_path
end

crumb :search do
  link t("Search_Items"), search_path
  parent :root
end

crumb :category do |category|
  link category, category_path(category)
  parent :root
end

crumb :sub_category do |category, sub_category|
  link sub_category, sub_category_path(category, sub_category)
  parent :category, category
end

crumb :brand do |brand|
  link brand, brand_path(brand)
  parent :root
end

crumb :item_category do |item|
  link item.category.title, category_path(item.category.title)
  parent :root
end

crumb :item_sub_category do |item|
  link item.sub_category.name, sub_category_path(item.category.title, item.sub_category.name)
  parent :item_category, item
end

crumb :item do |item|
  link item.name , item_path(item)
  if item.sub_category.present?
    parent :item_sub_category, item
  else
    parent :item_category, item
  end
end

crumb :seller do |seller|
  link seller.name, seller_profile_path(seller)
  parent :root
end

crumb :buyer do |buyer|
  link t("MyPage"), buyer_mypage_path
  parent :root
end

#Error_breadcrumbs

crumb :not_found do
  link "404 Error", error_404_path
  parent :root
end

crumb :internal_server_error do
  link "500 Error", error_500_path
  parent :root
end

#checkout Breadcrumns

crumb :checkout do |checkout_id|
  link t("Checkout"), checkout_path(checkout_id)
  parent :root
end

crumb :checkout_shipping_address do |checkout_id|
  link t("Shipping address"), checkout_shipping_address_path(checkout_id)
  parent :checkout, checkout_id
end

crumb :shipping_address do
  link t("Shipping address"), shipping_address_path
  parent :shipping_and_payment_info
end

crumb :checkout_payment_info do |checkout_id|
  link t("Payment Method"), checkout_payment_account_new_path(checkout_id) #not sure about this needs review because it is handling both #edit and #new for now.
  parent :checkout, checkout_id
end

crumb :payment_info do
  link t("Payment Method"),new_payment_account_path
  parent :shipping_and_payment_info
end

crumb :shipping_and_payment_info do
  link t("Shipping address / payment"), address_payments_path
  parent :buyer, current_user
end

crumb :purchase_history do
  link t("Purchase History"), purchase_history_path
  parent :buyer, current_user
end

crumb :review do |order_id, item_id|
  link t('Product review'), item_review_path(order_id, item_id)
  parent :purchase_history
  end

crumb :thankyou do |checkout_id|
  link t('Checkout Success'), checkout_success_path(checkout_id)
  parent :checkout, checkout_id
end

crumb :privacy do
  link t('Privacy policy'), privacy_path
  parent :root
end

crumb :terms_conditions do
  link t('Terms and conditions'), terms_conditions_path
  parent :root
end

crumb :followings do
  link t('followings'), followings_path
  parent :root
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
