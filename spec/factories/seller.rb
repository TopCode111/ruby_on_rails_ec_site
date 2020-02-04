FactoryBot.define do
  factory :seller do
    email { "k@g.c" }
    password { "12345678" }
    password_confirmation { "12345678" }
    after(:build) do |sp|
     sp.profile ||= FactoryBot.build(:seller_profile, :seller => sp)
    end
  end

  factory :seller_hide, class: Seller do
    email { "k12@g.c" }
    password { "12345678" }
    password_confirmation { "12345678" }
    after(:build) do |sp|
      sp.profile ||= FactoryBot.build(:seller_profile_hide, :seller => sp)
    end
  end
end
