# frozen_string_literal: true

class AddLastVisitToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_visit, :datetime
  end
end
