require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe '.from_params' do
    it 'creates a new ticket from params' do
      ticket_params = FactoryBot.attributes_for(:ticket)

      ticket = described_class.from_params(ticket_params)

      expect(ticket).to be_a(described_class)
      expect(ticket.request_number).to eq(ticket_params[:request_number.to_s])

    end

    it 'creates associated objects (excavator, date_and_times, digsite_info, etc.)' do
      ticket_params = FactoryBot.attributes_for(:ticket)

      ticket = nil
      expect {
        ticket = described_class.from_params(ticket_params)
        ticket.save
      }.to change(described_class, :count).by(1)

      expect(ticket).to be_persisted
      #expect(ticket.excavator).to be_a(Excavator)
      expect(ticket.date_and_times).to be_a(DateAndTimes)
      expect(ticket.digsite_info).to be_a(DigsiteInfo)
      #expect(ticket.additional_service_area_codes.length).to eq(3)
      #expect(ticket.primary_service_area_code).to be_a(ServiceAreaCode)
    end

    it 'handles missing params gracefully' do
      ticket = nil
      expect {
        ticket = described_class.from_params({})
      }.not_to change(described_class, :count)

      expect(ticket).to be_a(described_class)
      # Добавьте ожидания для значения по умолчанию или nil
    end
  end
end
