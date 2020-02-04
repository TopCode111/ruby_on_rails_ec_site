FactoryBot.define do
  factory :item do
    name { 'Fashion Love' }
    price { 1200 }
    description { 'This is fashion world' }
    shipping_fees { 0 }
    publish { true }
    category_id { 1 }
    sub_category_id { 1 }
    brand_id { 1 }
    seller_id { 1 }
    purchase_count { 0 }
    after :build do |item|
     item.images << FactoryBot.build(:image, item: item)
   end
  end
end
