# frozen_string_literal: true

class AddDeviseFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :remember_created_at, :datetime
  end
end
