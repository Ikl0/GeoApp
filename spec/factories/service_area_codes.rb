FactoryBot.define do
  factory :service_area_code do
    sequence(:sa_code) { |n| "ZZL#{format('%02d', n)}" }
    primary { false }

    trait :primary do
      primary { true }
    end
  end
end
