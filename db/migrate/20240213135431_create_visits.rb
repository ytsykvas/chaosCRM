# frozen_string_literal: true

class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.references :visitor, foreign_key: { to_table: :users }, null: false
      t.references :employee, foreign_key: { to_table: :users }, null: false
      t.integer :payment_status, default: 0
      t.datetime :visit_date, null: false
      t.string :comment
      t.json :conclusion

      t.timestamps
    end
  end
end
