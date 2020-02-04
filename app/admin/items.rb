ActiveAdmin.register Item, &CommonItem.default_config{
  menu priority:1
  permit_params :name, :description, :publish, :price, :shipping_fees, :seller_id, :category_id, :brand_id, :sub_category_id, images_attributes: [:id, :image, :_destroy], :quantities_attributes => [:id, :item_id, :size_id, :quantity, :_destroy]
  form partial: 'form'

  action_item :change_password, only: [:edit, :show] do
    link_to t('Change Password'),  edit_admin_seller_password_path(resource)
  end

  index do
    render 'admin/items/index', context: self
  end

  preserve_default_filters!
  remove_filter :purchase_orders, :buyers, :images, :reviews, :quantities, :description
  filter :sizes, collection: proc { Size.all.map{ |s| [s.size, s.id] } }

  action_item :create_seller, only: [:new, :edit] do
    link_to 'Create Seller',  new_admin_seller_path
  end
  action_item :create_brand, only: [:new, :edit] do
    link_to 'Create Brand',  new_admin_brand_path
  end
  action_item :create_category, only: [:new, :edit] do
    link_to 'Create Category',  new_admin_category_path
  end
  action_item :create_size, only: [:new, :edit] do
    link_to 'Create Size',  new_admin_size_path
  end
  action_item :comments, only: [:show] do
    link_to t('Comment to this product'), admin_item_item_comments_path(resource)
  end

  show do
    render 'admin/items/show', context: self
  end

  # form html: {class: "button-click"} do |f|
  #   f.inputs do
  #     f.input :seller_id, label: t('Seller'), :as => :select, :collection => Seller.all.map{|s| ["#{s.profile.name}", s.id]}, input_html: {class: 'chosen-select'}
  #     f.input :name
  #     f.input :brand_id, label: t('Brand'), as: :select, :collection => Brand.all.map {|b| ["#{b.name}", b.id] }, input_html: {class: 'chosen-select'}
  #     f.input :category_id, label: t('Category'), as: :select, :collection => Category.all.map {|c| ["#{c.title}", c.id ]}, input_html: {class: 'chosen-select js_category'}
  #     f.input :sub_category_id, label: 'Sub-Category', as: :select, :collection => SubCategory.all.map {|c| ["#{c.name}", c.id ]}, :input_html => {class:"js_subcategory chosen-select"}
  #     f.input :price, input_html:{min: 300}
  #     f.input :shipping_fees, input_html: {min: 0}
  #     f.input :description
  #     f.input :publish
  #     f.has_many :quantities, heading: t('Size'), allow_destroy: true do |s|
  #       s.input :size_id, as: :select, :collection => Size.all.map {|s| ["#{s.size}", s.id]}, input_html: {class: 'chosen-select'},label: t('Size Type'), include_blank: t('Select Size'), required: true
  #       s.input :quantity, required: true, label: t('Quantity')
  #     end
  #     f.has_many :images, heading: t('Image'), allow_destroy: true do |ff|
  #       ff.input :image, required: true, as: :file, input_html: {class: "js-img-validation"}, label: t('Image')
  #     end
  #   end
  #   f.actions
  # end

}

ActiveAdmin.register Item, namespace: :seller_admins, &CommonItem.default_config{
  menu priority: 2
  permit_params :name, :description, :publish, :price, :shipping_fees, :seller_id, :category_id, :brand_id, :sub_category_id, images_attributes: [:id, :image, :_destroy], :quantities_attributes => [:id, :item_id, :size_id, :quantity, :_destroy]
  form partial: '/admin/items/form'

  index do
    render 'admin/items/index', context: self
  end

  preserve_default_filters!
  remove_filter :purchase_orders, :buyers, :images, :reviews, :quantities, :description
  filter :sizes, collection: proc { Size.all.map{ |s| [s.size, s.id] } }


  show do
    render 'admin/items/show', context: self
  end

  action_item :comments, only: [:show] do
    link_to t('Comment to this product'), seller_admins_item_item_comments_path(resource)
  end

  controller do
    def scoped_collection
      seller = Seller.find(current_seller_admin.seller_id)
      Item.where(seller_id: seller.id)
    end
  end

}
