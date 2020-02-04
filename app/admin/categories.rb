ActiveAdmin.register Category do
  menu priority: 3
  permit_params :title, sub_categories_attributes: [:id, :name, :category_id, :_destroy]

  index do
    column :id
    column t('Category Title'), :title
    actions
  end
  remove_filter :items
  show do
    attributes_table do
      row t('Category Title') do |c|
        c.title
      end
      row t('Sub Categories') do |c|
        c.sub_categories.map(&:name).join(", ") if c.sub_categories.present?
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.has_many :sub_categories, heading: t('Sub Categories'), allow_destroy: true do |ff|
        ff.input :name
      end
    end
    f.actions
  end
end
