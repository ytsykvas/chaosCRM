class UserSettingsController < ApplicationController
  def block_customer
    endpoint UserSetting::Operation::BlockCustomer do |result|
      if result.errors.present?
        redirect_to customer_path(params['user_setting']['user_id']), alert: t('customers.block.error_alert')
      else
        redirect_to customer_path(params['user_setting']['user_id']), notice: t('customers.block.success_notice')
      end
    end
  end

  def unblock_customer
    endpoint UserSetting::Operation::UnblockCustomer do |result|
      if result.errors.present?
        redirect_to customer_path(params['user_setting']['user_id']), alert: t('customers.unblock.error_alert')
      else
        redirect_to customer_path(params[:format]), notice: t('customers.unblock.success_notice')
      end
    end
  end
end
