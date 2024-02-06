# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone
      t.string :first_name
      t.string :last_name
      t.string :encrypted_password
      t.string :type, null: false

      t.timestamps
    end
  end
end
