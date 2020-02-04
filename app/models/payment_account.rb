# == Schema Information
#
# Table name: payment_accounts
#
#  id                 :bigint(8)        not null, primary key
#  buyer_id           :integer
#  card_no            :integer
#  card_type          :string
#  stripe_customer_id :string
#  exp_month          :integer
#  exp_year           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class PaymentAccount < ApplicationRecord
  belongs_to :buyer
end
