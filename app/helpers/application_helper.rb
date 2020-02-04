module ApplicationHelper

  def meta_description(description = nil)
    if description.present?
      content_for :meta_description, "#{description} - Pick Official Buyerがセレクトした商品を購入できるファッション通販サイト『Pick』。"
    else
     content_for :meta_description, "Pick Official Buyerがセレクトした商品を購入できるファッション通販サイト『Pick』。"
   end
  end

  def title(title = nil)
    if title.present?
      content_for :title,  "#{title} | Pick"
    else
      content_for :title, "Pick"
    end
  end

  def add_class
    if ((params[:controller]== 'registrations') || (params[:controller]== 'devise/sessions') || (params[:action]== 'checkout_user_register') || (params[:action]== 'checkout_new_password') || (params[:controller]== 'passwords') || (params[:action]== 'shipping_address') || (params[:controller]== 'payment_accounts') || (params[:action]== 'success'))
      add_class="session-page"
    else
      add_class=" "
    end
  end
end
