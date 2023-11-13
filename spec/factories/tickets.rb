FactoryBot.define do
  factory :ticket do
    request_number { "09252012-00001" }
    sequence_number { 2421 }
    request_type { "Normal" }
    request_action { "Restake" }

    association :excavator, strategy: :build

    after(:build) do |ticket|
      ticket.excavator ||= build_stubbed(:excavator, ticket: ticket)
    end

    trait :with_additional_service_area_codes do
      after(:build) do |ticket|
        ticket.additional_service_area_codes << build_list(:service_area_code, 3, ticket: ticket, primary: false)
      end
    end

    after(:build) do |ticket|
      ticket.primary_service_area_code ||= build(:service_area_code, ticket: ticket, primary: true)
    end
  end
end
