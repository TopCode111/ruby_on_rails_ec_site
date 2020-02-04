class RegistrationsController < Devise::RegistrationsController

  def create
    super do |resource|
      if resource.present? && resource.profile.present?
        fname = params[:user][:profile]['first_name']
        lname = params[:user][:profile]['last_name']
        resource.profile.update_attributes(first_name: fname,
                                           last_name: lname)
      end
    end
  end

  protected

  def sign_up_params
    if params[:user][:type] == 'Buyer'
      params.require(:user).permit(:email,
                                   :password,
                                   :password_confirmation,
                                   :type,
                                   :profile_attributes => [:id,
                                                           :first_name,
                                                           :last_name,
                                                           :buyer_id])
    end
  end
end