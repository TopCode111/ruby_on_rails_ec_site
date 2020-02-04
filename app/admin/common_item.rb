module CommonItem
  def self.default_config(&block)
    proc{
      controller do
        before_action :except => [:index, :new, :create, :sub_categories_list] do
          @item = Item.friendly.find(params[:id])
        end

        def update
          if @item.update_attributes(item_params)
            @item.update(sub_category_id: nil) unless @item.category.sub_categories.present?
            flash[:success] = t('Item successfully updated')
            if params[:controller] == "admin/items"
              redirect_to admin_item_path(@item.id)
            elsif params[:controller] == "seller_admins/items"
              redirect_to seller_admins_item_path(@item.id)
            end
          else
            super
          end
        end

        def publish_item
          @item.update(publish: true)
          if params[:controller] == "admin/items"
            redirect_to admin_items_path
          elsif params[:controller] == "seller_admins/items"
            redirect_to seller_admins_items_path
          end
        end

        def unpublish_item
          @item.update(publish: false)
          if params[:controller] == "admin/items"
            redirect_to admin_items_path
          elsif params[:controller] == "seller_admins/items"
            redirect_to seller_admins_items_path
          end
        end

        private
        def item_params
          params.require(:item).permit(:name,
                                       :description,
                                       :price,
                                       :publish,
                                       :shipping_fees,
                                       :seller_id,
                                       :category_id,
                                       :brand_id,
                                       :sub_category_id,
                                       images_attributes: [:id,
                                                           :image,
                                                           :_destroy],
                                       quantities_attributes: [:id,
                                                               :size_id,
                                                               :item_id,
                                                               :quantity,
                                                               :_destroy])
        end
    end
    instance_exec(&block) if block_given?
  }
  end
end
