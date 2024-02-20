class UsersController < ApplicationController
  def update
    endpoint User::Operation::Update do |result|
      if result.errors.present?
        redirect_to customer_path(params[:id]), alert: t('customers.edit.error_update')
      else
        redirect_to customer_path(params[:id]), notice: t('customers.edit.success_update')
      end
    end
  end
end
