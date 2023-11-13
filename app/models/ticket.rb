# frozen_string_literal: true

class Ticket < ApplicationRecord
  has_one :excavator
  accepts_nested_attributes_for :excavator
  has_one :date_and_times
  has_one :digsite_info
  has_many :additional_service_area_codes, lambda {
                                             where(primary: false)
                                           }, class_name: 'ServiceAreaCode', foreign_key: 'ticket_id'
  accepts_nested_attributes_for :additional_service_area_codes
  has_one :primary_service_area_code, lambda {
                                        where(primary: true)
                                      }, class_name: 'ServiceAreaCode', foreign_key: 'ticket_id'

  def self.from_params(params)
    ticket = new(
      request_number: params[:RequestNumber],
      sequence_number: params[:SequenceNumber],
      request_type: params[:RequestType],
      request_action: params[:RequestAction],
      date_and_times: DateAndTimes.new(response_due_date_time: params.dig(:DateTimes, :ResponseDueDateTime)),
      digsite_info: DigsiteInfo.new(well_known_text: params.dig(:ExcavationInfo, :DigsiteInfo, :WellKnownText)),
      primary_service_area_code: ServiceAreaCode.new(primary: true,
                                                     sa_code: params.dig(
                                                       :ServiceArea, :PrimaryServiceAreaCode, :SACode
                                                     ))
    )

    area_code_params = params.dig(:ServiceArea, :AdditionalServiceAreaCodes, :SACode)
    if area_code_params.present?
      area_code_params.map do |area_code|
        ticket.additional_service_area_codes.build(sa_code: area_code, ticket: ticket, primary: false)
      end
    end

    excavator_code_params = params[:Excavator]
    if excavator_code_params.present?
      address = excavator_code_params.values_at(:City, :State, :Zip, :Address).join(', ')
      ticket.build_excavator(address: address,
                             company_name: excavator_code_params[:CompanyName],
                             crew_on_site: (!!excavator_code_params[:CrewOnsite]))
    end
    ticket
  end
end
