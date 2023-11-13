# frozen_string_literal: true

FactoryBot.define do
  factory :excavator do
    company_name { 'John Doe CONSTRUCTION' }
    address { '555 Some RD' }
    crew_on_site { true }
  end
end
