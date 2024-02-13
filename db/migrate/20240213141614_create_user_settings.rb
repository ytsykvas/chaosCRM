# frozen_string_literal: true

class CreateUserSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :user_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0
      t.integer :language, default: 0
      t.boolean :deposit_required, default: true
      t.json :comment

      t.timestamps
    end
  end
end
