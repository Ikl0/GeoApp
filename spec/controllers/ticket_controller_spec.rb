# spec/controllers/tickets_controller_spec.rb
require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          RequestNumber: '09252012-00001',
          SequenceNumber: 2421,
          RequestType: 'Normal',
          RequestAction: 'Restake',
          DateTimes: { ResponseDueDateTime: '2011/07/13 23:59:59' },
          ExcavationInfo: { DigsiteInfo: { WellKnownText: "POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,-81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,-81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,-81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,-81.13390268058475 32.07206917625161))" } },
          Excavator: {
            City: 'SOME PARK',
            State: 'ZZ',
            Zip: '55555',
            Address: '555 Some RD',
            CompanyName: 'John Doe CONSTRUCTION',
            CrewOnSite: true
          },
          ServiceArea: {
            PrimaryServiceAreaCode: { SACode: 'ZZGL103' },
            AdditionalServiceAreaCodes: { SACode: ['ZZL01', 'ZZL02', 'ZZL03'] }
          }
        }
      end

      it 'creates a new ticket' do
        expect {
          post :create, params: valid_params
        }.to change(Ticket, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to have_key('id')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { invalid_key: -1 } }

      it 'returns unprocessable_entity status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET #index' do
    it 'returns a success response' do
      create(:ticket)
      get :index
      expect(response).to be_successful
      expect(assigns(:tickets)).not_to be_nil
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      ticket = create(:ticket)
      get :show, params: { id: ticket.id }
      expect(response).to be_successful
      expect(assigns(:ticket)).to eq(ticket)
    end
  end
end
