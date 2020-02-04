class PasswordsController < Devise::PasswordsController
  protected
  def after_sending_reset_password_instructions_path_for(resource_name)
    if request.referer.present? && request.referer.split('/').include?('cart')
      cart_path
    else
      super
    end
  end
end