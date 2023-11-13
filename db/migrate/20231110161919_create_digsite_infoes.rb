# frozen_string_literal: true

class CreateDigsiteInfoes < ActiveRecord::Migration[7.0]
  def change
    create_table :digsite_infos do |t|
      t.string :well_known_text
      t.references :ticket

      t.timestamps
    end
  end
end
