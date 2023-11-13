# frozen_string_literal: true

class AddNotNullConstraintsToTickets < ActiveRecord::Migration[7.0]
  def change
    change_column :tickets, :request_number, :string, null: false
    change_column :tickets, :sequence_number, :bigint, null: false
    change_column :tickets, :request_type, :string, null: false
    change_column :tickets, :request_action, :string, null: false
  end
end
