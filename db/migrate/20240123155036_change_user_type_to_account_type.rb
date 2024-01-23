class ChangeUserTypeToAccountType < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :type
    add_column :users, :account_type, :string, default: 'visitor', null: false
  end
end
