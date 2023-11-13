# frozen_string_literal: true

class CreateServiceAreaCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :service_area_codes do |t|
      t.string :sa_code
      t.boolean :primary
      t.references :ticket

      t.timestamps
    end
  end
end
