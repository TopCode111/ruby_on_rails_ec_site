FactoryBot.define do
  factory :payment_account do
    buyer_id { 1 }
    card_no { 4242 }
    card_type { "VISA" }
    stripe_customer_id { "1234" }
    exp_month { 4 }
    exp_year {2019}
  end
end
