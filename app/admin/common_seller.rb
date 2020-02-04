module CommonSeller
  def self.default_config(&block)
    proc {
      controller do
        before_action :except => [:index, :new, :create, :list_seller, :unlist_seller] do
          @seller = Seller.friendly.find(params[:id])
        end

        def update
          super
          create_update_seller_info(resource, params[:seller][:email])
        end

        def list_seller
          @seller = Seller.find(params[:id])
          @seller.profile.update(hide: false)
          if params[:controller] == "admin/sellers"
            redirect_to admin_sellers_path
          elsif params[:controller] == "seller_admins/sellers"
            redirect_to seller_admins_sellers_path
          end
        end

        def unlist_seller
          @seller = Seller.find(params[:id])
          @seller.profile.update(hide: true)
          if params[:controller] == "admin/sellers"
            redirect_to admin_sellers_path
          elsif params[:controller] == "seller_admins/sellers"
            redirect_to seller_admins_sellers_path
          end
        end

        private
        def create_update_seller_info(seller, email = nil, password = nil, password_confirmation = nil)
          if seller.seller_admin.present?
            seller.seller_admin.update(email: email) if params[:controller] == 'admin/sellers' || params[:controller] == 'seller_admins/sellers'
            seller.seller_admin.update(password: password, password_confirmation: password_confirmation) if params[:controller] == 'admin/seller_passwords' || params[:controller] == 'seller_admins/seller_passwords'
          else
            seller_admin  = seller.create_seller_admin(email: email, password: password, password_confirmation: password_confirmation)
            seller_admin.save!
          end
        end
    end
    instance_exec(&block) if block_given?
    }
  end
end
