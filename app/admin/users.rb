ActiveAdmin.register User do
  menu priority: 7

  index do
    column :id
    column :email
    column t('First name'), :first_name do |c|
      c.profile.try(:first_name)
    end
    column t('Last name'), :last_name do |c|
      c.profile.try(:last_name)
    end
    column t('Billing Address'), :billing_address do |c|
      if c.billing_address.present?
        c.billing_address.try(:prefecture) + c.billing_address.try(:address_1) + c.billing_address.try(:address_2)
      else
        "-"
      end
    end
  end

  filter :email

  controller do
    actions :all, except: [:new, :edit, :destroy]
    def scoped_collection
      Buyer.all
    end
  end
end
