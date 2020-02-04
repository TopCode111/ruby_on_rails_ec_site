FactoryBot.define do
  factory :review do
   description {"Fake description"}
   rating { 3 }
   item_id  { 1 }
   seller_id { 1 }
   buyer_id { 1 }
  end
end
