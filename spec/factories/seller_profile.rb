FactoryBot.define do
  factory :seller_profile do
    name { "Pick Official" }
    description { "Fake description about PickOfficial"}
    photo {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'buyer_default_avatar.png'))}
  end
  factory :seller_profile_hide, class: SellerProfile do
    name { "Pick Official" }
    description { "Fake description about PickOfficial"}
    hide {true}
    photo {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'buyer_default_avatar.png'))}
  end
end
