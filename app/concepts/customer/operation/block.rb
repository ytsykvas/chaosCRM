# frozen_string_literal: true

class Customer::Operation::Block < Operation::Base
  def perform!(user:, params:)
    authorize!(:customers, :edit?)
    self.model = {
      setting: find_or_create_setting(params[:id])
    }
  end

  def find_or_create_setting(customer_id)
    customer = User.find(customer_id)
    if customer.user_setting.present?
      customer.user_setting
    else
      UserSetting.create!(user: customer)
    end
  end
end
