class UsersController < ApplicationController
  def update
    endpoint User::Operation::Update do |result|
      if result.errors.present?
        redirect_to customers_path, alert: t('customers.edit.error_update')
      else
        redirect_to customers_path, notice: t('customers.edit.success_update')
      end
    end
  end
end
