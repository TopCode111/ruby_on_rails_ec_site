ActiveAdmin.register Seller, &CommonSeller.default_config{
  menu priority: 2
  permit_params :email, :password, :password_confirmation ,profile_attributes: [:id, :seller_id,  :name, :description, :photo, :instagram_url, :twitter_url, :line_url, :facebook_url, :hide]

  index do
    render 'admin/sellers/index', context: self
  end

  filter  :email

  action_item :change_password, only: [:edit, :show] do
    link_to t('Change Password'),  edit_admin_seller_password_path(resource)
  end


  show do
    render 'admin/sellers/show', context: self
  end

  form do |f|
    # f.object.build_profile
    f.inputs t("Seller Profile") do
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.semantic_fields_for :profile do |r|
        r.inputs :name
        r.inputs :photo, as: :file
        r.inputs :description
        r.inputs :hide
        r.inputs :instagram_url
        r.inputs :twitter_url
        r.inputs :line_url
        r.inputs :facebook_url
      end
    end
    f.actions
  end

  controller do
    def new
      @seller= Seller.new
      @seller.build_profile
    end

    def create
      super
      create_update_seller_info(resource, params[:seller][:email], params[:seller][:password], params[:seller][:password_confirmation]) unless resource.new_record?
    end

  end
}

ActiveAdmin.register Seller, namespace: :seller_admins, &CommonSeller.default_config{
  menu priority: 1
  permit_params :email, :password, :password_confirmation ,profile_attributes: [:id, :seller_id,  :name, :description, :photo, :instagram_url, :twitter_url, :line_url, :facebook_url, :hide]
  actions :all, except: [:new, :index,  :create, :destroy]

  filter :email

  show do
    render "admin/sellers/show", context: self
  end

  action_item :change_password, only: [:edit, :show] do
    link_to t('Change Password'),  edit_seller_admins_seller_password_path(resource)
  end

  form do |f|
    # f.object.build_profile
    f.inputs "Seller Profile" do
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.semantic_fields_for :profile do |r|
        r.inputs :name
        r.inputs :photo, as: :file
        r.inputs :description
        r.inputs :hide
        r.inputs :instagram_url
        r.inputs :twitter_url
        r.inputs :line_url
        r.inputs :facebook_url
      end
    end
    f.actions
  end

  controller do
    def index
      redirect_to(seller_admins_seller_path(current_seller_admin.seller))
    end
  end
}


