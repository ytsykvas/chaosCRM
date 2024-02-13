# frozen_string_literal: true

class CreateApplicationSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :application_settings do |t|
      t.integer :minimal_deposit, default: 200

      t.timestamps
    end
  end
end
