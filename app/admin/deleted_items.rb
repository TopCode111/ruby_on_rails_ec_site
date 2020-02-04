ActiveAdmin.register Item, as: 'Deleted Items' do
  menu label: '削除されたアイテム', priority: 8

  actions :all, except: [:new, :edit]

  index do
    column :id
    column t('Item Name'), :name
    column t('Seller Name') do |s|
      s.seller.try(:name) if s.seller.present?
    end
    column t('Item Price'), :price
    column t('Brand') do |b|
      b.brand.try(:name) if b.brand.present?
    end
    actions
  end

  show do
    attributes_table do
      row t('Seller Name') do |i|
        i.seller.try(:name) if i.seller.present?
      end
      row t('Item Name') do |i|
        i.try(:name)
      end
      row t('Brand') do |i|
        i.brand.try(:name) if i.brand.present?
      end
      row t('Category') do |i|
        i.category.try(:title) if i.category.present?
      end
      row t('Sub Categories') do |i|
        i.sub_category.try(:name) if i.sub_category.present?
      end
      row :price
      row :shipping_fees
      row :description
      row :publish
      panel t('Sizes') do
        table_for resource.quantities do
          column t('Size Type') do |q|
            q.size.size
          end
          column t('Quantity'),:quantity
        end
      end
      row t('Item Images') do |item|
        ul class:"item_list" do
          item.images.each do |img|
            li do
              image_tag img.image.url(:thumb)
            end
          end
        end
      end
    end
  end

  controller do
    before_action :except => [:index, :new, :create] do
      @deleted_items = Item.only_deleted.friendly.find(params[:id])
    end

    def scoped_collection
      item = Item.only_deleted
    end

    def destroy
      @deleted_items.really_destroy!
      redirect_to admin_deleted_items_path
    end
  end
end
