module ValidBuyer
  extend ActiveSupport::Concern

  def check_valid_buyer
    if @order.present? && (@order.buyer.present? && @order.buyer != current_user)
      flash[:alert] = t("You are not allowed to perform this action")
      redirect_to root_path
    end
  end
end
