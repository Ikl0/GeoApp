# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :request_number
      t.bigint :sequence_number
      t.string :request_type
      t.string :request_action

      t.timestamps
    end
  end
end
