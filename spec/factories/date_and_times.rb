FactoryBot.define do
  factory :date_and_times do
    response_due_date_time { Time.now + 1.day }
    association :ticket
  end
end
