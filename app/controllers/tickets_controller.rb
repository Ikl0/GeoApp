# frozen_string_literal: true

class TicketsController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def index
    @tickets = Ticket.all
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def create
    @ticket = Ticket.from_params(ticket_params)

    if @ticket.save
      render json: @ticket, status: :created
    else
      render json: { errors: [@ticket.errors] }, status: :unprocessable_entity
    end
  end

  private

  def ticket_params
    params.permit(
      :RequestNumber, :SequenceNumber, :RequestType, :RequestAction,
      { DateTimes: [:ResponseDueDateTime] },
      { ExcavationInfo: { DigsiteInfo: [:WellKnownText] } },
      { Excavator: %i[City State Zip Address CompanyName CrewOnSite] },
      { ServiceArea: {
        PrimaryServiceAreaCode: [:SACode],
        AdditionalServiceAreaCodes: [SACode: []]
      } }
    )
  end
end
