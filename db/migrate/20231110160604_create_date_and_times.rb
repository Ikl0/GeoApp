# frozen_string_literal: true

class CreateDateAndTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :date_and_times do |t|
      t.datetime :response_due_date_time
      t.references :ticket

      t.timestamps
    end
  end
end
