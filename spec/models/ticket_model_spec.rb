# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe '.from_params' do
    it 'creates a ticket' do
      ticket_params = FactoryBot.attributes_for(:ticket)

      ticket = described_class.from_params(ticket_params)

      expect(ticket).to be_a(described_class)
      expect(ticket.request_number).to eq(ticket_params[:request_number.to_s])
    end

    it 'associated objects are nil if ticket is nil' do
      ticket_params = FactoryBot.attributes_for(:ticket)

      ticket = nil
      expect do
        ticket = described_class.from_params(ticket_params)
        ticket&.save
      end.to change(described_class, :count).by(0)

      expect(ticket).to be_a(described_class)
      expect(ticket&.excavator).to be_nil
      expect(ticket&.date_and_times&.response_due_date_time).to be_nil
      expect(ticket&.digsite_info&.well_known_text).to be_nil
      expect(ticket&.additional_service_area_codes).to be_empty
      expect(ticket&.primary_service_area_code&.sa_code).to be_nil
    end

    it 'handles missing params gracefully' do
      ticket = nil
      expect do
        ticket = described_class.from_params({})
      end.not_to change(described_class, :count)

      expect(ticket).to be_a(described_class)
    end
  end
end
