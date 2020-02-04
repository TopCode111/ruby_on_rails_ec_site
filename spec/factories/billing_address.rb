FactoryBot.define do
  factory :billing_address do
    address_1  { "BabarMahal" }
    address_2  {"BuddhaNagar"}
    city { "Kathmandu" }
    prefecture { "Long" }
    zip_code { "12345" }
    buyer_id { 1 }
  end
end
