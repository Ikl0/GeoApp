# spec/models/digsite_info_spec.rb

require 'rails_helper'

RSpec.describe DigsiteInfo, type: :model do
  describe '#match_clear_coord' do
    context 'when well_known_text is present' do
      let(:digsite_info) { build(:digsite_info, well_known_text: well_known_text) }

      context 'with valid well_known_text' do
        let(:well_known_text) { 'POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,-81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,-81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,-81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,-81.13390268058475 32.07206917625161))' }

        it 'returns an array of coordinates' do
          coordinates = digsite_info.match_clear_coord
          expect(coordinates).to be_an(Array)
          expect(coordinates).to eq([
                                      [-81.13390268058475, 32.07206917625161],
                                      [-81.14660562247929, 32.04064386441295],
                                      [-81.08858407706913, 32.02259853170128],
                                      [-81.05322183341679, 32.02434500961698],
                                      [-81.05047525138554, 32.042681017283066],
                                      [-81.0319358226746, 32.06537765335268],
                                      [-81.01202310294804, 32.078469305179404],
                                      [-81.02850259513554, 32.07963291684719],
                                      [-81.07759774894413, 32.07090546831167],
                                      [-81.12154306144413, 32.08806865844325],
                                      [-81.13390268058475, 32.07206917625161]
                                    ])
        end
      end

      context 'with invalid well_known_text' do
        let(:digsite_info) { build(:digsite_info, well_known_text: 'INVALID_TEXT') }

        it 'returns an empty array' do
          coordinates = digsite_info.match_clear_coord
          expect(coordinates).to be_an(Array)
          expect(coordinates).to be_empty
        end
      end
    end

    context 'when well_known_text is blank' do
      let(:digsite_info) { build(:digsite_info, well_known_text: nil) }

      it 'returns an empty array' do
        coordinates = digsite_info.match_clear_coord
        expect(coordinates).to be_an(Array)
        expect(coordinates).to be_empty
      end
    end
  end
end
