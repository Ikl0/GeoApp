# frozen_string_literal: true

class DigsiteInfo < ApplicationRecord
  belongs_to :ticket

  def match_clear_coord
    return [] unless well_known_text.present?

    coordinates_match = well_known_text.match(/\(\(([-\d.]+ [-\d.]+(,[-\d.]+ [-\d.]+)*)\)\)/)

    if coordinates_match
      coordinates_str = coordinates_match[1]
      coordinates_str.split(',').map { |coord| coord.split.map(&:to_f) }

    else
      []
    end
  end
end
