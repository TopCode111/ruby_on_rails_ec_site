ActiveAdmin.register User, as: 'Seller Password', &CommonSeller.default_config{
  menu false
  permit_params :password, :password_confirmation

  controller do
    before_action only: [:edit, :update, :show] do
      @seller_password = Seller.friendly.find(params[:id])
    end
    actions :all, except:[:new, :destroy, :index]

    def index
      redirect_to admin_sellers_path
    end

    def update
      update! do |format|
        create_update_seller_info(resource, resource.email, params[:user][:password], params[:user][:password_confirmation])
        flash[:notice] = "Successfully, password updated"
        format.html {redirect_to admin_sellers_path}
      end
    end
  end


  form do |f|
    f.inputs t("Change Password") do
      f.input :password
      f.input :password_confirmation, input_html: {class: 'user_password_confirmation'}
    end
    f.action :submit, label: t("Change Password"), as: :button ,button_html: {class: 'hide_list pwd-button'}
  end


}

ActiveAdmin.register User, as: 'Seller Password', namespace: :seller_admins, &CommonSeller.default_config{
  menu false
  permit_params :password, :password_confirmation

   form do |f|
    f.inputs t("Change Password") do
      f.input :password
      f.input :password_confirmation, input_html: {class: 'user_password_confirmation'}
    end
    f.action :submit, label: t("Change Password"), as: :button ,button_html: {class: 'hide_list pwd-button'}
  end

  controller do
    before_action only: [:edit, :update, :show] do
      @seller_password = Seller.friendly.find(params[:id])
    end
    actions :all, except:[:new, :destroy, :index]

    def index
      redirect_to seller_admins_seller_password_path(current_seller_admin.seller)
    end

    def update
      update! do |format|
        create_update_seller_info(resource, resource.email, params[:user][:password], params[:user][:password_confirmation])
        flash[:notice] = 'Successfully, password updated'
        format.html {redirect_to seller_admins_seller_path(resource)}
      end
    end
  end

}
