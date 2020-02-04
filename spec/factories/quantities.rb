FactoryBot.define do
  factory :quantity do
   item_id { 1 }
   size_id { 1 }
   quantity {10}
   remaining  { 8 }
   purchased { 2 }
  end
end
